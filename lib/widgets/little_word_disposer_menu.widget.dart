import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../model/model.dart';
import '../utils/utils.dart';

class LittleWordDisposerMenu extends StatefulWidget {
  const LittleWordDisposerMenu({Key? key, required this.note}) : super(key: key);

  final DbNote note;

  @override
  State<LittleWordDisposerMenu> createState() => _LittleWordDisposerMenuState();
}

class _LittleWordDisposerMenuState extends State<LittleWordDisposerMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await noteProvider.deleteNote(widget.note.id.v).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Destroy the word'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await submitWord(context, ref, widget.note.wordField.v!).then((_) async {
                    await noteProvider.deleteNote(widget.note.id.v).then((_) {
                      Navigator.pop(context);
                    });
                  });
                },
                child: const Text('Throw the word away'),
              ),
            ],
          ),
        );
      },
    );
  }
}
