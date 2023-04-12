// ignore_for_file: prefer_const_constructors, directives_ordering, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/utils/utils.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  // void _deleteNoteFromList(DbNote note) {
  //   setState(() {
  //     noteProvider.deleteNote(note.id);
  //   });
  // }

  // void _showConfirmationDialog(DbNote note) {

  // }

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
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
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Jeter"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(
                                        context); // Ferme la boîte de dialogue modale
                                    await noteProvider.deleteNote(
                                        note.id.v); // Supprime la note
                                    setState(
                                        () {}); // Rafraîchit la liste des notes
                                  },
                                  child: Text("Detruire"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                });
          },
        ),
      );
    });
  }
}
