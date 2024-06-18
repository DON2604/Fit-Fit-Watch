import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:http/http.dart' as http;
import 'package:watch/backend/aipro.dart';
import 'package:watch/screens/achivements.dart';
import 'dart:convert';
import 'dart:async';

import 'package:watch/widgets/step_gauge.dart';
import 'package:watch/widgets/temperature.dart';

class ColData extends StatefulWidget {
  const ColData({super.key});

  @override
  State<ColData> createState() {
    return _ColData();
  }
}

class _ColData extends State<ColData> {
  int steps = 0;

  @override
  void initState() {
    super.initState();
    _fetchSteps();
    Timer.periodic(const Duration(seconds: 2), (timer) {
       rain();
      _fetchSteps();
    });
  }

  Future<void> _fetchSteps() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.29.190:5000/steps'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          steps = data['steps'];
        });
      } else {
        throw Exception('Failed to load steps');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Temperature(),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 14.0),
                child: Text(
                  "Fit-Fit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AchievementsScreen(
                            completedSteps: 6000,
                            completedDistance: 7, 
                            completedCalories: 1100,
                          )),
                    );
                  },
                  child: const Icon(
                    FontAwesome5Solid.medal,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
        ClipRect(
          child: StepGauge(steps: steps),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 58.0),
                    child: Text(
                      "STEPS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0),
                    child: Text(
                      "$steps",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "DISTANCE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "80.0 km",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                color: Colors.white,
                thickness: 2,
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 58.0),
                    child: Text(
                      "HEAT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 58.0),
                    child: Text(
                      "0.0 Kcal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25)
      ],
    );
  }
}
