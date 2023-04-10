import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/words_around.provider.dart';
import 'little_word_card.widget.dart';

class LittleWordsList extends StatefulWidget {
  const LittleWordsList({Key? key}) : super(key: key);

  @override
  State<LittleWordsList> createState() => _LittleWordsListState();
}

class _LittleWordsListState extends State<LittleWordsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final words = ref.watch(wordsAroundProvider).when(
          data: (value) => value,
          loading: () => null,
          error: (error, stackTrace) => null);

      if (words != null && words.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Words around you',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return LittleWordCard(word: words[index]);
                },
              ),
            ),
          ],
        );
      } else {
        return const Center();
      }
    });
  }
}
