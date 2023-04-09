// // ignore_for_file: prefer_const_constructors, directives_ordering

// import 'package:flutter/material.dart';
// import 'package:tekartik_common_utils/common_utils_import.dart';
// import 'package:tekartik_notepad_sqflite_app/main.dart';
// import 'package:tekartik_notepad_sqflite_app/model/model.dart';
// import 'package:tekartik_notepad_sqflite_app/page/edit_page.dart';
// import 'package:tekartik_notepad_sqflite_app/page/note_page.dart';

// class NoteListPage extends StatefulWidget {
//   const NoteListPage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _NoteListPageState createState() => _NoteListPageState();
// }

// class _NoteListPageState extends State<NoteListPage> {
//   // void _showConfirmationDialog() {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return Container(
//   //         height: 200,
//   //         child: Column(
//   //           children: [
//   //             ElevatedButton(
//   //               onPressed: () {
//   //                 Navigator.pop(context);
//   //               },
//   //               child: Text("Jeter"),
//   //             ),
//   //             ElevatedButton(
//   //               onPressed: () {
//   //                 Navigator.pop(context);
//   //               },
//   //               child: Text("Detruire"),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // List<String> words =
//     //     ModalRoute.of(context)?.settings.arguments as List<String>;
//     // return LayoutBuilder(builder: (context, constraints) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Address Book',
//           ),
//         ),

//         body: StreamBuilder<List<DbNote?>>(
//           stream: noteProvider.onNotes(),
//           builder: (context, snapshot) {
//             var notes = snapshot.data;
//             if (notes == null) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return ListView.builder(
//               itemCount: notes.length,
//               itemBuilder: (context, index) {
//                 var note = notes[index]!;
//                 return ListTile(
//                   title: Text(note.title.v ?? ''),
//                   subtitle: note.content.v?.isNotEmpty ?? false
//                       ? Text(LineSplitter.split(note.content.v!).first)
//                       : null,
//                       onTap: () {
//                         // _showConfirmationDialog();
//                       },
//                     );
//                   });
//             })
//       );
//     }
//   }

// // class MyList extends StatelessWidget {
// //   final List<String> items;

// //   MyList({required this.items});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       itemCount: items.length,
// //       itemBuilder: (context, index) {
// //         return ElevatedButton(
// //           onPressed: () {
// //             // Action à effectuer lorsqu'on appuie sur le bouton
// //             _NoteListPageState()._showConfirmationDialog();
// //           },
// //           child: Text(items[index]),
// //         );
// //       },
// //     );
// //   }
// // }

// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/page/edit_page.dart';
import 'package:tekartik_notepad_sqflite_app/page/note_page.dart';

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
  // Widget _deleteSingleContactDialog(BuildContext context, DbNote note) {
  //   return AlertDialog(
  //     icon: Icon(Icons.warning),
  //     title: Text('Delete contact'),
  //     content: Text('Are you sure you want to delete this contact ?'),
  //     actions: [
  //       TextButton(
  //         child: Text('CANCEL'),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       TextButton(
  //         child: Text('DELETE'),
  //         onPressed: () {
  //           noteProvider.deleteNote(note.id.v!);
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _deleteContactsDialog(BuildContext context) {
  //   return AlertDialog(
  //     icon: Icon(Icons.warning),
  //     title: Text('Delete all contacts'),
  //     content: Text('Are you sure you want to delete all your contacts ?'),
  //     actions: [
  //       TextButton(
  //         child: Text('CANCEL'),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       TextButton(
  //         child: Text('DELETE'),
  //         onPressed: () {
  //           noteProvider.clearAllNotes();
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ],
  //   );
  // }

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

          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.delete),
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return _deleteContactsDialog(context);
          //         },
          //       );
          //     },
          //   )
          // ],
        ),
        body: StreamBuilder<List<DbNote?>>(
          // Expanded(
          // child: Center(

          // )
          // ),
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
