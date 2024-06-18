import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Records {
  final bool isRecording;
  final int elapsedSeconds;
  final double distanceTravelled;
  final List<LatLng> routeCoordinates;
  final Timer? timer;

  Records({
    this.isRecording = false,
    this.elapsedSeconds = 0,
    this.distanceTravelled = 0.0,
    this.routeCoordinates = const [],
    this.timer,
  });

  Records copyWith({
    bool? isRecording,
    int? elapsedSeconds,
    double? distanceTravelled,
    List<LatLng>? routeCoordinates,
    Timer? timer,
  }) {
    return Records(
      isRecording: isRecording ?? this.isRecording,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      distanceTravelled: distanceTravelled ?? this.distanceTravelled,
      routeCoordinates: routeCoordinates ?? this.routeCoordinates,
      timer: timer ?? this.timer,
    );
  }
}
