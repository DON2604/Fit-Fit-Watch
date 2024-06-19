import 'package:flutter/material.dart';

class TemperatureProvider with ChangeNotifier {
  String _temperature = '0°C';

  String get temperature => _temperature;

  void setTemperature(String temperature) {
    _temperature = temperature;
    notifyListeners();
  }
}
