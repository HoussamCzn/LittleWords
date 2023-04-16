import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/utils.dart';

class LittleWordCreator extends StatefulWidget {
  const LittleWordCreator({Key? key}) : super(key: key);

  @override
  State<LittleWordCreator> createState() => _LittleWordCreatorState();
}

class _LittleWordCreatorState extends State<LittleWordCreator> {
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
                TextFormField(
                  controller: wordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your word',
                    border: OutlineInputBorder(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Word must not be empty';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await submitWord(context, ref, wordController.text.trim())
                          .then((value) {
                        if (value) {
                          const snackbar = SnackBar(
                            content: Text('Word successfully shared !'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          const snackbar = SnackBar(
                            content: Text('Failure when sharing word !'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text('Share'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
