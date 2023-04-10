// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/page/note_page.dart';
import 'package:tekartik_notepad_sqflite_app/page/test_boutonplapa.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Jeter"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Detruire"),
              ),
            ],
          ),
        );
      },
    );
  }

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Widget page;
    //  permet de constituer une page
    // switch (selectedIndex) {
    //   case 0:
    //     page = NotePage(
    //       noteId: null,
    //     );
    //     break;
    //   case 1:
    //     page = NoteListPage();
    //     break;
    //   default:
    //     throw UnimplementedError('no widget for $selectedIndex');
    // }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Address Book',
          ),
        ),
        body: StreamBuilder<List<DbNote?>>(
          stream: noteProvider.onNotes(),
          builder: (context, snapshot) {
            var notes = snapshot.data;
            if (notes == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  var note = notes[index]!;

                  // return Text("mot proche de toi");
                  // style:
                  //     TextStyle(height: 20, fontWeight: FontWeight.bold));

                  return ListTile(
                    title: Text(
                        '${note.usernameField.v ?? ''}  ${note.wordField.v ?? ''}'),
                    // subtitle: note.noteFirstName.v?.isNotEmpty ?? false
                    // ? Text(LineSplitter.split(note.wordField.v!).first)
                    //     : null,
                    onTap: () {
                      _showConfirmationDialog();
                    },
                  );
                });
          },
        ),
      );
    });
  }
}
