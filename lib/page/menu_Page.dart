// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:tekartik_notepad_sqflite_app/page/test_boutonplapa.dart';

import 'list_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MenuPage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    //  permet de constituer une page
    switch (selectedIndex) {
      case 0:
        page = Testbouton();
        break;
      case 1:
        page = NoteListPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.map),
                    label: Text('Word arround'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.pages),
                    label: Text('Create Word'),
                  ),
                ],

                //  selectionner une nouvelle page
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                  print('selected: $value');
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
