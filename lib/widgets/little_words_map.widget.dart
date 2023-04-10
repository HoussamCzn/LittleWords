import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../provider/device_location.provider.dart';
import '../provider/words_around.provider.dart';

class LittleWordsMap extends StatefulWidget {
  const LittleWordsMap({Key? key}) : super(key: key);

  @override
  State<LittleWordsMap> createState() => _LittleWordsMapState();
}

class _LittleWordsMapState extends State<LittleWordsMap> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final location = ref.watch(deviceLocationProvider).when(
          data: (value) => value,
          loading: () => null,
          error: (error, stackTrace) => null);

      final words = ref.watch(wordsAroundProvider).when(
          data: (value) => value,
          loading: () => null,
          error: (error, stackTrace) => null);

      if (words != null && location != null) {
        return FlutterMap(
          options: MapOptions(
            center: location,
            zoom: 13.0,
          ),
          children: [
            TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c']),
            MarkerLayer(markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: location,
                builder: (context) => const Icon(
                  Icons.location_on_sharp,
                  color: Colors.red,
                ),
              ),
              ...words
                  .map((word) => Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(word.latitude!, word.longitude!),
                        builder: (context) => const Icon(
                          Icons.location_on_sharp,
                          color: Colors.purple,
                        ),
                      ))
                  .toList()
            ]),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
