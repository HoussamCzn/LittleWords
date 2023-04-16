// ignore_for_file: prefer_const_constructors, directives_ordering, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import '../widgets/little_word_put_map_widget.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
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

                  return ListTile(
                    title: Text(
                        '${note.usernameField.v ?? ''}  ${note.wordField.v ?? ''}'),
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
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return LittleWordPutMap(
                                              word: note.wordField.v ?? '');
                                        });
                                    Navigator.pop(context);
                                    await noteProvider.deleteNote(note.id.v);
                                    setState(() {});
                                  },
                                  child: Text('Throw'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await noteProvider.deleteNote(note.id.v);
                                    setState(() {});
                                  },
                                  child: Text('Delete'),
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
