// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tekartik_notepad_sqflite_app/page/test_boutonplapa.dart';
// import 'package:tekartik_common_utils/common_utils_import.dart';
// import 'package:tekartik_notepad_sqflite_app/main.dart';
// import 'package:tekartik_notepad_sqflite_app/model/model.dart';
// import 'package:tekartik_notepad_sqflite_app/page/edit_page.dart';
// import 'package:tekartik_notepad_sqflite_app/page/note_page.dart';

class UsernameInput extends StatefulWidget {
  const UsernameInput({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UsernameInputState createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter your username'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.25),child: Column(
      
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _submitUsername();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Testbouton(),
              ),
            );
          },
          child: Text('Submit'),
        ),
      ],
    )));
  }

  Future<void> _submitUsername() async {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}

// class NoteListPage extends StatefulWidget {
//   const NoteListPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _NoteListPageState createState() => _NoteListPageState();
// }

// class _NoteListPageState extends State<NoteListPage> {
//   Widget _deleteSingleContactDialog(BuildContext context, DbNote note) {
//     return AlertDialog(
//       icon: Icon(Icons.warning),
//       title: Text('Delete contact'),
//       content: Text('Are you sure you want to delete this contact ?'),
//       actions: [
//         TextButton(
//           child: Text('CANCEL'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('DELETE'),
//           onPressed: () {
//             noteProvider.deleteNote(note.id.v!);
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _deleteContactsDialog(BuildContext context) {
//     return AlertDialog(
//       icon: Icon(Icons.warning),
//       title: Text('Delete all contacts'),
//       content: Text('Are you sure you want to delete all your contacts ?'),
//       actions: [
//         TextButton(
//           child: Text('CANCEL'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('DELETE'),
//           onPressed: () {
//             noteProvider.clearAllNotes();
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Address Book',
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return _deleteContactsDialog(context);
//                 },
//               );
//             },
//           )
//         ],
//       ),
//       body: StreamBuilder<List<DbNote?>>(
//         stream: noteProvider.onNotes(),
//         builder: (context, snapshot) {
//           var notes = snapshot.data;
//           if (notes == null) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return ListView.builder(
//               itemCount: notes.length,
//               itemBuilder: (context, index) {
//                 var note = notes[index]!;
//                 return ListTile(
//                   title: Text(
//                       '${note.noteLastName.v ?? ''} ${note.noteFirstName.v ?? ''}'),
//                   subtitle: note.noteFirstName.v?.isNotEmpty ?? false
//                       ? Text(LineSplitter.split(note.notePhone.v!).first)
//                       : null,
//                   onTap: () {
//                     Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return NotePage(
//                         noteId: note.id.v,
//                       );
//                     }));
//                   },
//                   onLongPress: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return _deleteSingleContactDialog(context, note);
//                       },
//                     );
//                   },
//                 );
//               });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return EditNotePage(initialNote: null);
//           }));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
