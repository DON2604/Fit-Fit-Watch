import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Achievements",
                  style: TextStyle(
                    fontSize: 21.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Image.asset(
            'assets/badges/bad1.png',
            height: 250,
            width: 250,
          ),
          const Text(
            "STEP STARTER",
            style: TextStyle(
              fontSize: 17.5,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(88, 30, 66, 1),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesome5Solid.coins,
                color: Color.fromARGB(255, 231, 175, 7),
                size: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left:15.0),
                child: Text(
                  "6000 Coins",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 65,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                FontAwesome5Solid.shoe_prints,
                size: 32,
                color: Color.fromARGB(255, 4, 181, 21),
              ),
              Column(
                children: [
                  ProgressBar(
                    value: 0.7,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                    backgroundColor: Colors.grey.withOpacity(0.4),
                    width: 280,
                    height: 13,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 150.0),
                    child: Row(
                      children: [
                        Text(
                          "Steps --",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "9000",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                FontAwesome5Solid.heartbeat,
                size: 32,
                color: Color.fromARGB(255, 199, 16, 3),
              ),
              Column(
                children: [
                  ProgressBar(
                    value: 0.7,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                    backgroundColor: Colors.grey.withOpacity(0.4),
                    width: 280,
                    height: 13,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 100.0),
                    child: Row(
                      children: [
                        Text(
                          "Calorie --",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "9000 Kcal",
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
