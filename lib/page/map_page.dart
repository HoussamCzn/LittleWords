// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';

import '../provider/device_location.provider.dart';
import '../provider/words_around.provider.dart';
import '../widgets/little_word_creator.widget.dart';
import '../widgets/little_words_list.widget.dart';
import '../widgets/little_words_map.widget.dart';
import '../widgets/refreshable_app_bar.widget.dart';
import 'package:tekartik_notepad_sqflite_app/page/list_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int navigationIndex = 0;
  final bodies = [
    const FirstPage(),
    const NoteListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RefreshableAppBar(
            title: 'LittleWords',
            refreshables: navigationIndex == 0
                ? [deviceLocationProvider, wordsAroundProvider]
                : []),
        body: bodies[navigationIndex],
        floatingActionButton: navigationIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const LittleWordCreator();
                      });
                },
                tooltip: 'Add a new word',
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books),
              label: 'My words',
            ),
          ],
          currentIndex: navigationIndex,
          onTap: (index) {
            setState(() {
              navigationIndex = index;
            });
          },
        ));
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 150,
          child: LittleWordsList(),
        ),
        Expanded(
          child: LittleWordsMap(),
        ),
      ],
    );
  }
}

// class SecondPage extends StatelessWidget {
//   const SecondPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Second Page'),
//     );
//   }
// }
