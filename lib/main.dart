// ignore_for_file: directives_ordering, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekartik_app_flutter_sqflite/sqflite.dart';
import 'package:tekartik_app_platform/app_platform.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';

import 'page/login_page.dart';
import 'provider/note_provider.dart';

late DbNoteProvider noteProvider;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  platformInit();
  if (!kIsWeb) {
    sqfliteWindowsFfiInit();
  }
  var packageName = 'com.tekartik.sqflite.notepad';
  var databaseFactory = getDatabaseFactory(packageName: packageName);

  noteProvider = DbNoteProvider(databaseFactory);
  await noteProvider.ready;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LittleWords',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
