import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tekartik_notepad_sqflite_app/page/note_page.dart';
import 'package:tekartik_common_utils/common_utils_import.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/page/list_page.dart';

import 'package:latlong2/latlong.dart';

import 'edit_page.dart';

class Testbouton extends StatefulWidget {
  final DbNote? initialNote;
  const Testbouton({Key? key, this.initialNote}) : super(key: key);

  @override
  _TestboutonState createState() => _TestboutonState();
}

class _TestboutonState extends State<Testbouton> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _messageTextController;
  int? get _noteId => widget.initialNote?.id.v;

  void initState() {
    super.initState();
    _messageTextController =
        TextEditingController(text: widget.initialNote?.wordField.v);
  }

  Future save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await noteProvider.saveNote(DbNote()
        ..id.v = _noteId
        // ..usernameField.v = _lastNameTextController!.text
        ..usernameField.v = _messageTextController!.text);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (_noteId != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  void _showConfirmationDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: Text("Jeter"),
              // ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'message',
                  border: OutlineInputBorder(),
                ),
                controller: _messageTextController,
                validator: (val) =>
                    val!.isNotEmpty ? null : 'message must not be empty',
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  save();
                },
                child: Text("Deposer le mot"),
              ),
            ],
          ),
        );
      },
    );
  }

  // au lieu d'un Alertdialog je voudrais un Showmodalbottomsheet avec 2 boutons et un texte en dessous du texte j'ai un bouton qui ferme la fenetre
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Littlewords"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              // child: Text("data"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('mot proche de toi',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  ListTile(
                    // onPressed: _showConfirmationDialog,
                    title: Text('bouton 1'),
                  ),
                  SizedBox(height: 5),
                  ListTile(
                    // onPressed: _showConfirmationDialog,
                    title: Text('bouton 2'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 500,
            height: 200,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(45.5231, -122.6765),
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(45.5231, -122.6765),
                      builder: (ctx) => Container(
                        child: const Icon(
                          Icons.location_on,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showConfirmationDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
