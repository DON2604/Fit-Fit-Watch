import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'package:watch/helpers/database_helper.dart';
import 'package:watch/screens/record_detail.dart';

final recordsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return await DatabaseHelper().getRecords();
});

class RecordListScreen extends ConsumerWidget {
  const RecordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsyncValue = ref.watch(recordsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recorded Routes')),
      body: recordsAsyncValue.when(
        data: (records) {
          if (records.isEmpty) {
            return const Center(child: Text('No records found'));
          }

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              final routeCoordinates = (jsonDecode(record['route']) as List)
                  .map((point) => LatLng(point['lat'], point['lng']))
                  .toList();
              final duration = record['duration'];
              final distance = record['distance'];

              return ListTile(
                title: Text('Record ${record['id']}'),
                subtitle: Text(
                    'Duration: ${duration ~/ 60}:${(duration % 60).toString().padLeft(2, '0')}, Distance: ${distance.toStringAsFixed(2)} km'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RecordDetailScreen(
                      routeCoordinates: routeCoordinates,
                      duration: duration,
                      distance: distance,
                    ),
                  ));
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text('Error loading records')),
      ),
    );
  }
}
