// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';

class EditNotePage extends StatefulWidget {
  /// null when adding a note
  final DbNote? initialNote;

  const EditNotePage({Key? key, required this.initialNote}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _lastNameTextController;
  TextEditingController? _firstNameTextController;
  TextEditingController? _phoneTextController;
  TextEditingController? _addressTextController;

  int? get _noteId => widget.initialNote?.id.v;
  @override
  void initState() {
    super.initState();
    _lastNameTextController =
        TextEditingController(text: widget.initialNote?.noteLastName.v);
    _firstNameTextController =
        TextEditingController(text: widget.initialNote?.noteFirstName.v);
    _phoneTextController =
        TextEditingController(text: widget.initialNote?.notePhone.v);
    _addressTextController =
        TextEditingController(text: widget.initialNote?.noteAddress.v);
  }

  Future save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await noteProvider.saveNote(DbNote()
        ..id.v = _noteId
        ..noteLastName.v = _lastNameTextController!.text
        ..noteFirstName.v = _firstNameTextController!.text
        ..noteDate.v = DateTime.now().millisecondsSinceEpoch
        ..notePhone.v = _phoneTextController!.text
        ..noteAddress.v = _addressTextController!.text);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (_noteId != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool validatePhoneNumber(String phoneNumber) {
      final pattern = RegExp(r'^(\+?\d{1,3}[- ]?)?\d{9}$');
      final stripedNumber = phoneNumber.replaceAll(' ', '');
      return pattern.hasMatch(stripedNumber);
    }

    return WillPopScope(
      onWillPop: () async {
        var dirty = false;
        if (_lastNameTextController!.text !=
            widget.initialNote?.noteLastName.v) {
          dirty = true;
        } else if (_firstNameTextController!.text !=
            widget.initialNote?.noteFirstName.v) {
          dirty = true;
        }
        if (dirty) {
          return await (showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Discard changes ?'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Content has changed.'),
                            SizedBox(
                              height: 12,
                            ),
                            Text('Tap \'CONTINUE\' to discard your changes.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('CONTINUE'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Text('CANCEL'),
                        ),
                      ],
                    );
                  })) ??
              false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Note',
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                save();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          border: OutlineInputBorder(),
                        ),
                        controller: _lastNameTextController,
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : 'Last name must not be empty',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'First name',
                          border: OutlineInputBorder(),
                        ),
                        controller: _firstNameTextController,
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : 'First name must not be empty',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          border: OutlineInputBorder(),
                        ),
                        controller: _phoneTextController,
                        validator: (val) =>
                            val!.isNotEmpty && validatePhoneNumber(val)
                                ? null
                                : 'Not a valid phone number',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        controller: _addressTextController,
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : 'Address must not be empty',
                      ),
                    ]))
          ]),
        ),
      ),
    );
  }
}
