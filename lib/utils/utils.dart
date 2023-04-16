// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../beans/dto/word.dto.dart';
import '../main.dart';
import '../model/model.dart';
import '../provider/device_location.provider.dart';
import '../provider/dio.provider.dart';
import '../provider/words_around.provider.dart';

Future<void> saveWordToDatabase(
    BuildContext context, WidgetRef ref, WordDTO word) async {
  final dio = ref.read(dioProvider);
  final url =
      '/word?uid=${word.uid}&latitude=${word.latitude}&longitude=${word.longitude}';
  final res = await dio.get(url).then((response) {
    if (response.statusCode != 200) {
      throw Exception('Failed to load word');
    } else {
      return response.data['data'];
    }
  });

  final note = DbNote()
    ..usernameField.value = res['author'].toString()
    ..wordField.value = res['content'].toString()
    ..dateField.value = DateTime.now().millisecondsSinceEpoch;

  await noteProvider.saveNote(note);

  ref.invalidate(deviceLocationProvider);
  ref.invalidate(wordsAroundProvider);
}

Future<bool> submitWord(
    BuildContext context, WidgetRef ref, String text) async {
  final prefs = await SharedPreferences.getInstance();
  final username = prefs.get('username').toString();
  final dio = ref.read(dioProvider);
  const url = '/word';

  ref.invalidate(deviceLocationProvider);
  ref.invalidate(wordsAroundProvider);

  final location = ref.read(deviceLocationProvider).when(
      data: (value) => value,
      loading: () => null,
      error: (error, stackTrace) => null);

  if (location != null) {
    final word =
        WordDTO(null, username, text, location.latitude, location.longitude);
    await dio.post(url, data: word.toJson());

    return true;
  }

  return false;
}

String logTruncate(String text) {
  var len = 128;
  if (text.length > len) {
    text = text.substring(0, len);
  }
  return text;
}
