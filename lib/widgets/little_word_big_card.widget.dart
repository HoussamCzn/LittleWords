import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../beans/dto/word.dto.dart';
import '../utils/utils.dart';

class LittleWordBigCard extends StatelessWidget {
  const LittleWordBigCard({Key? key, required this.word}) : super(key: key);

  final WordDTO word;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: InkWell(
              onTap: () {
                saveWordToDatabase(context, ref, word);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const SizedBox(height: 8),
                    Text(
                      '#${word.uid.toString()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Déposé par: ${word.author}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
