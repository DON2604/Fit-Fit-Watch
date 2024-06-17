import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() {
    return _RecordScreenState();
  }
}

class _RecordScreenState extends State<RecordScreen> {
  GoogleMapController? _controller;
  final Location _location = Location();

  final Set<Polyline> _polylines = {};
  final List<LatLng> _routeCoordinates = [];
  bool _isRecording = false;
  Timer? _timer;
  int _elapsedSeconds = 0;
  double _distanceTravelled = 0.0;
  LatLng? _lastPosition;

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (_isRecording) {
        _updateRoute(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      }
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedSeconds += 1;
        });
      });
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _timer?.cancel();
      _timer = null;
      _elapsedSeconds = 0;
      _distanceTravelled = 0.0;
      _routeCoordinates.clear();
      _polylines.clear();
    });
  }

  void _updateRoute(LatLng position) {
    setState(() {
      if (_lastPosition != null) {
        _distanceTravelled += _calculateDistance(_lastPosition!, position);
      }
      _lastPosition = position;
      _routeCoordinates.add(position);
      _polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: _routeCoordinates,
        color: Colors.blue,
        width: 5,
      ));
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.7,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    _location.getLocation().then((location) {
                      _controller!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(location.latitude!, location.longitude!),
                            zoom: 15,
                          ),
                        ),
                      );
                    });
                  },
                  myLocationEnabled: true,
                  polylines: _polylines,
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.3,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Time: ${_elapsedSeconds ~/ 60}:${(_elapsedSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Distance: ${_distanceTravelled.toStringAsFixed(2)} km',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _isRecording ? _stopRecording : _startRecording,
                      child: Text(_isRecording ? 'Stop' : 'Start'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
