import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekartik_notepad_sqflite_app/beans/dto/word.dto.dart';
import 'package:tekartik_notepad_sqflite_app/beans/dto/words.dto.dart';
import 'package:tekartik_notepad_sqflite_app/provider/device_location.provider.dart';
import 'package:tekartik_notepad_sqflite_app/provider/dio.provider.dart';

final wordsAroundProvider = FutureProvider<List<WordDTO>>((ref) async {
  final location = ref.watch(deviceLocationProvider);

  return location.map(data: (data) async {
    final dio = ref.read(dioProvider);
    final response = await dio.get(
        '/word/around?latitude=${data.value!.latitude}&longitude=${data.value!.longitude}');

    var jsonAsString = response.toString();
    var json = jsonDecode(jsonAsString);

    final wordsDTO = WordsDTO.fromJson(json as Map<String, dynamic>);
    if (wordsDTO.data == null) {
      return Future.value([]);
    }

    return Future.value(wordsDTO.data!);
  }, error: (error) {
    return Future.value([]);
  }, loading: (loading) {
    return Future.value([]);
  });
});
