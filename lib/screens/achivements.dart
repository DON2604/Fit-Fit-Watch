import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:watch/screens/store.dart';
import 'package:watch/widgets/progess_container.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({
    super.key,
    required this.completedSteps,
    required this.completedDistance,
    required this.completedCalories,
  });

  final int targetSteps = 9000;
  final int targetDistance = 10;
  final int targetCalories = 1000;
  final int completedSteps;
  final int completedDistance;
  final int completedCalories;

  String getProgressString(int target, int completed) {
    if (completed >= target) {
      return 'Completed';
    } else {
      return '${target - completed} remaining';
    }
  }

  double getProgressValue(int target, int completed) {
    if (completed >= target) {
      return 1;
    } else {
      return completed/target;
    }
  }

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
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 21.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 221, 221),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome5Solid.coins,
                        color: Color.fromARGB(255, 231, 175, 7),
                        size: 32,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "6000 Coins",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 231, 175, 7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const StoreScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 255, 211, 79), // Yellow color for the button
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 5,
                    minimumSize: const Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Set border radius
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Store'),
                      SizedBox(width: 8),
                      Icon(Icons.storefront),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          ProgessContainer(
            icon: FontAwesome5Solid.shoe_prints,
            iconColor: const Color.fromARGB(255, 4, 181, 21),
            goal: '$targetSteps Steps',
            reward: '100 Coins',
            progress: getProgressString(targetSteps, completedSteps),
            progressValue: getProgressValue(targetSteps, completedSteps),
          ),
          const SizedBox(
            height: 28,
          ),
          ProgessContainer(
            icon: MaterialCommunityIcons.map_marker_distance,
            iconColor: const Color.fromARGB(255, 245, 0, 0),
            goal: '$targetDistance Km',
            reward: '150 Coins',
            progress: getProgressString(targetDistance, completedDistance),
            progressValue: getProgressValue(targetDistance, completedDistance),
          ),
          const SizedBox(
            height: 28,
          ),
          ProgessContainer(
            icon: FontAwesome.heartbeat,
            iconColor: const Color.fromARGB(255, 255, 217, 0),
            goal: '$targetCalories Cal',
            reward: '50 Coins',
            progress: getProgressString(targetCalories, completedCalories),
            progressValue: getProgressValue(targetCalories, completedCalories),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
