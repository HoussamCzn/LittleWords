import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model.dart';
import 'little_word_disposer_menu.widget.dart';

class LittleWordBigCard extends StatelessWidget {
  const LittleWordBigCard({Key? key, required this.uid, required this.note}) : super(key: key);

  final int uid;
  final DbNote note;

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
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return LittleWordDisposerMenu(note: note);
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      '#${uid.toString()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      note.wordField.v!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Dropped by: ${note.usernameField.v}',
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
