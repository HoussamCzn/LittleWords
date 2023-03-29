import 'package:geocoding/geocoding.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/model/model_constant.dart';

DbNote snapshotToNote(Map<String, Object?> snapshot) {
  return DbNote()..fromMap(snapshot);
}

class DbNotes extends ListBase<DbNote> {
  final List<Map<String, Object?>> list;
  late List<DbNote?> _cacheNotes;

  DbNotes(this.list) {
    _cacheNotes = List.generate(list.length, (index) => null);
  }

  @override
  DbNote operator [](int index) {
    return _cacheNotes[index] ??= snapshotToNote(list[index]);
  }

  @override
  int get length => list.length;

  @override
  void operator []=(int index, DbNote? value) => throw 'read-only';

  @override
  set length(int newLength) => throw 'read-only';
}

class DbNoteProvider {
  final lock = Lock(reentrant: true);
  final DatabaseFactory dbFactory;
  final _updateTriggerController = StreamController<bool>.broadcast();
  Database? db;

  DbNoteProvider(this.dbFactory);

  Future openPath(String path) async {
    db = await dbFactory.openDatabase(path,
        options: OpenDatabaseOptions(
            version: kVersion1,
            onCreate: (db, version) async {
              await _createDb(db);
            },
            onUpgrade: (db, oldVersion, newVersion) async {
              if (oldVersion < kVersion1) {
                await _createDb(db);
              }
            }));
  }

  void _triggerUpdate() {
    _updateTriggerController.sink.add(true);
  }

  Future<Database?> get ready async => db ??= await lock.synchronized(() async {
        if (db == null) {
          await open();
        }
        return db;
      });

  Future<DbNote?> getNote(int? id) async {
    var list = (await db!.query(tableContacts,
        columns: [
          columnId,
          lastName,
          firstName,
          date,
          phone,
          address,
          latitude,
          longitude
        ],
        where: '$columnId = ?',
        whereArgs: <Object?>[id]));
    if (list.isNotEmpty) {
      return DbNote()..fromMap(list.first);
    }
    return null;
  }

  Future _createDb(Database db) async {
    await db.execute('DROP TABLE If EXISTS $tableContacts');
    await db.execute(
        'CREATE TABLE $tableContacts($columnId INTEGER PRIMARY KEY, $lastName TEXT, $firstName TEXT, $date INTEGER, $phone TEXT, $address TEXT, $latitude DOUBLE, $longitude DOUBLE)');
    await db.execute('CREATE INDEX NotesUpdated ON $tableContacts ($date)');
    await _saveNote(
        db,
        DbNote()
          ..noteLastName.v = 'CUMZAIN'
          ..noteFirstName.v = 'Houssam'
          ..noteDate.v = DateTime.now().millisecondsSinceEpoch
          ..notePhone.v = '+33661505054'
          ..noteAddress.v = '420 Rue Raymond Telly'
          ..noteLatitude.v = 51.0171447
          ..noteLongitude.v = 2.3349419);

    _triggerUpdate();
  }

  Future open() async {
    await openPath(await fixPath(dbName));
  }

  Future<String> fixPath(String path) async => path;

  Future _saveNote(DatabaseExecutor? db, DbNote updatedNote) async {
    var locations =
        await locationFromAddress((updatedNote.noteAddress.v) as String);
    updatedNote.noteLatitude.v = locations[0].latitude;
    updatedNote.noteLongitude.v = locations[0].longitude;
    updatedNote.noteLastName.v = updatedNote.noteLastName.v?.toUpperCase();
    if (updatedNote.noteFirstName.v != null) {
      updatedNote.noteFirstName.v =
          updatedNote.noteFirstName.v![0].toUpperCase() +
              updatedNote.noteFirstName.v!.substring(1);
    }
    if (updatedNote.notePhone.v != null) {
      updatedNote.notePhone.v = updatedNote.notePhone.v!.replaceAll(' ', '');
    }
    if (updatedNote.id.v != null) {
      await db!.update(tableContacts, updatedNote.toMap(),
          where: '$columnId = ?', whereArgs: <Object?>[updatedNote.id.v]);
    } else {
      updatedNote.id.v = await db!.insert(tableContacts, updatedNote.toMap());
    }
  }

  Future saveNote(DbNote updatedNote) async {
    await _saveNote(db, updatedNote);
    _triggerUpdate();
  }

  Future<void> deleteNote(int? id) async {
    await db!.delete(tableContacts,
        where: '$columnId = ?', whereArgs: <Object?>[id]);
    _triggerUpdate();
  }

  var notesTransformer =
      StreamTransformer<List<Map<String, Object?>>, List<DbNote>>.fromHandlers(
          handleData: (snapshotList, sink) {
    sink.add(DbNotes(snapshotList));
  });

  var noteTransformer =
      StreamTransformer<Map<String, Object?>, DbNote?>.fromHandlers(
          handleData: (snapshot, sink) {
    sink.add(snapshotToNote(snapshot));
  });

  Stream<List<DbNote?>> onNotes() {
    late StreamController<DbNotes> controller;
    StreamSubscription? triggerSubscription;

    Future<void> sendUpdate() async {
      var notes = await getListNotes();
      if (!controller.isClosed) {
        controller.add(notes);
      }
    }

    controller = StreamController<DbNotes>(onListen: () {
      sendUpdate();

      triggerSubscription = _updateTriggerController.stream.listen((_) {
        sendUpdate();
      });
    }, onCancel: () {
      triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  Stream<DbNote?> onNote(int? id) {
    late StreamController<DbNote?> controller;
    StreamSubscription? triggerSubscription;

    Future<void> sendUpdate() async {
      var note = await getNote(id);
      if (!controller.isClosed) {
        controller.add(note);
      }
    }

    controller = StreamController<DbNote?>(onListen: () {
      sendUpdate();

      triggerSubscription = _updateTriggerController.stream.listen((_) {
        sendUpdate();
      });
    }, onCancel: () {
      triggerSubscription?.cancel();
    });
    return controller.stream;
  }

  Future<DbNotes> getListNotes(
      {int? offset, int? limit, bool? descending}) async {
    var list = (await db!.query(tableContacts,
        columns: [columnId, lastName, firstName, phone, address],
        orderBy: '$date ${(descending ?? false) ? 'ASC' : 'DESC'}',
        limit: limit,
        offset: offset));
    return DbNotes(list);
  }

  Future clearAllNotes() async {
    await db!.delete(tableContacts);
    _triggerUpdate();
  }

  Future close() async {
    await db!.close();
  }

  Future deleteDb() async {
    await dbFactory.deleteDatabase(await fixPath(dbName));
  }
}
