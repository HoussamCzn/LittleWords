// ignore_for_file: prefer_const_constructors, directives_ordering, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../main.dart';
import '../model/model.dart';
import '../widgets/little_word_big_card.widget.dart';

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
                  final note = notes[index];
                  if (note != null) {
                    return LittleWordBigCard(uid: index, note: note);
                  }
                });
          },
        ),
      );
    });
  }
}
