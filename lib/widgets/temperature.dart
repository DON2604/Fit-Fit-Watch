import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() {
    return _TemperatureWidgetState();
  }
}

class _TemperatureWidgetState extends State<Temperature> {
  String _temperature = '0°C';

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndFetchTemperature();
  }

  Future<void> _checkPermissionsAndFetchTemperature() async {
    if (await _handleLocationPermission()) {
      _fetchTemperature();
    } else {
      setState(() {
        _temperature = 'Location permission denied';
      });
    }
  }

  Future<bool> _handleLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
      return status.isGranted;
    } else {
      return false;
    }
  }

  Future<void> _fetchTemperature() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double latitude = position.latitude;
      double longitude = position.longitude;

      String apiKey =
          'e1896349d647ae5208c3f5bea5d107c9'; // Replace with your OpenWeatherMap API key
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey';

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          _temperature = '${data['main']['temp']}°C';
        });
      } else {
        setState(() {
          _temperature = 'Error fetching temperature';
        });
      }
    } catch (e) {
      setState(() {
        _temperature = 'Error fetching temperature';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _temperature,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    );
  }
}
