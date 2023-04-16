import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

class LittleWordPutMap extends StatefulWidget {
  const LittleWordPutMap({Key? key}) : super(key: key);

  @override
  State<LittleWordPutMap> createState() => _LittleWordPutMapState();
}

class _LittleWordPutMapState extends State<LittleWordPutMap> {
  final formKey = GlobalKey<FormState>();
  final wordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submitWord(context, ref, wordController.text.trim());
                    }
                  },
                  child: const Text('Throw'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
