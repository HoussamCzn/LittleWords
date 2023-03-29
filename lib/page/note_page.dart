// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:latlong2/latlong.dart';
import 'package:tekartik_notepad_sqflite_app/main.dart';
import 'package:tekartik_notepad_sqflite_app/model/model.dart';
import 'package:tekartik_notepad_sqflite_app/page/edit_page.dart';

class NotePage extends StatefulWidget {
  final int? noteId;

  const NotePage({Key? key, required this.noteId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DbNote?>(
      stream: noteProvider.onNote(widget.noteId),
      builder: (context, snapshot) {
        var note = snapshot.data;
        void call() {
          if (note != null) {
            FlutterPhoneDirectCaller.callNumber(note.notePhone.v!);
          }
        }

        void edit() {
          if (note != null) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EditNotePage(
                initialNote: note,
              );
            }));
          }
        }

        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Contact details',
              ),
              actions: <Widget>[
                if (note != null)
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      call();
                    },
                  ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    edit();
                  },
                ),
              ],
            ),
            body: (note == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    child: ListView(children: <Widget>[
                      ListTile(title: Text(note.noteLastName.v ?? '')),
                      ListTile(title: Text(note.noteFirstName.v ?? '')),
                      ListTile(title: Text(note.notePhone.v ?? '')),
                      ListTile(title: Text(note.noteAddress.v ?? '')),
                      SizedBox(
                        width: 50,
                        height: 500,
                        child: FlutterMap(
                          options: MapOptions(
                              center: LatLng(
                                  note.noteLatitude.v!, note.noteLongitude.v!),
                              zoom: 12),
                          nonRotatedChildren: [
                            AttributionWidget.defaultWidget(
                              source: 'OpenStreetMap contributors',
                              onSourceTapped: null,
                            ),
                          ],
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(note.noteLatitude.v!,
                                      note.noteLongitude.v!),
                                  width: 80,
                                  height: 80,
                                  builder: (context) => Icon(
                                    Icons.location_on,
                                    color: Colors.purple,
                                    size: 40.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ));
      },
    );
  }
}
