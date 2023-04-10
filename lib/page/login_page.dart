// ignore_for_file: prefer_const_constructors, directives_ordering

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page/map_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.25),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Username', border: OutlineInputBorder()),
                    validator: (value) =>
                        value!.isEmpty ? 'Username is required' : null,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitUsername();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MapPage()));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            )));
  }

  Future<void> _submitUsername() async {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}