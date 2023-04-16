import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../beans/dto/word.dto.dart';
import '../utils/utils.dart';

class LittleWordCard extends StatelessWidget {
  const LittleWordCard({Key? key, required this.word}) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: InkWell(
              onTap: () async {
                await saveWordToDatabase(context, ref, word).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Word saved to database'),
                    ),
                  );
                });
              },
              child: SizedBox(
                width: 90,
                child: Center(child: Text('#${word.uid.toString()}')),
              ),
            ),
          ),
        );
      },
    );
  }
}
