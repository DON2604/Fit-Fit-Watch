import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:watch/screens/achivements.dart';

import 'package:watch/widgets/step_gauge.dart';
import 'package:watch/widgets/temperature.dart';

class ColData extends StatefulWidget {
  const ColData({
    super.key,
    required this.totalDistanceToday,
    required this.totalStepsToday,
    required this.totalCaloriesToday,
  });

  final double totalDistanceToday;
  final int totalStepsToday;
  final double totalCaloriesToday;

  @override
  State<ColData> createState() {
    return _ColData();
  }
}

class _ColData extends State<ColData> {

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
                          builder: (context) => AchievementsScreen(
                                completedSteps: widget.totalStepsToday,
                                completedDistance: widget.totalDistanceToday,
                                completedCalories: widget.totalCaloriesToday,
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
          child: StepGauge(steps: widget.totalStepsToday),
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
                      widget.totalStepsToday.toString(),
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
              Column(
                children: [
                  const Padding(
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
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      widget.totalDistanceToday.toStringAsFixed(2),
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
              Column(
                children: [
                  const Padding(
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
                    padding: const EdgeInsets.only(right: 58.0),
                    child: Text(
                      widget.totalCaloriesToday.toStringAsFixed(2),
                      style: const TextStyle(
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
