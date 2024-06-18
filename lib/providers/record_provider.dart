import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watch/helpers/database_helper.dart';
import 'package:watch/model/records.dart';

final recordProvider = StateNotifierProvider<RecordingStateNotifier, Records>((ref) {
  return RecordingStateNotifier();
});

class RecordingStateNotifier extends StateNotifier<Records> {
  RecordingStateNotifier() : super(Records());

  void startRecording() {
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
    state = state.copyWith(isRecording: true, timer: timer);
  }

  void stopRecording() async {
    state.timer?.cancel();
    await _saveRecord();
    state = Records();
  }

  void updateRoute(LatLng position) {
    final lastPosition = state.routeCoordinates.isEmpty ? null : state.routeCoordinates.last;
    final newDistance = lastPosition != null ? _calculateDistance(lastPosition, position) : 0.0;
    final newRouteCoordinates = List<LatLng>.from(state.routeCoordinates)..add(position);
    state = state.copyWith(
      distanceTravelled: state.distanceTravelled + newDistance,
      routeCoordinates: newRouteCoordinates,
    );
  }

  Future<void> _saveRecord() async {
    String routeJson = jsonEncode(state.routeCoordinates.map((e) => {'lat': e.latitude, 'lng': e.longitude}).toList());
    Map<String, dynamic> record = {
      'date': DateTime.now().toIso8601String(),
      'duration': state.elapsedSeconds,
      'distance': state.distanceTravelled,
      'route': routeJson,
    };

    await DatabaseHelper().insertRecord(record);
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double R = 6371e3; // metres
    final double phi1 = start.latitude * (3.14159 / 180);
    final double phi2 = end.latitude * (3.14159 / 180);
    final double deltaPhi = (end.latitude - start.latitude) * (3.14159 / 180);
    final double deltaLambda = (end.longitude - start.longitude) * (3.14159 / 180);

    final double a = (sin(deltaPhi / 2) * sin(deltaPhi / 2)) +
        (cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2));
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c / 1000; // returns the distance in kilometers
  }
}