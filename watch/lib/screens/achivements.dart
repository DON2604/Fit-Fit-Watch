import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:watch/model/FitnessAppModel.dart';
import 'package:watch/screens/store.dart';
import 'package:watch/widgets/progess_container.dart';
import 'package:watch/providers/fitnessappprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({
    Key? key,
    required this.completedSteps,
    required this.completedDistance,
    required this.completedCalories,
  }) : super(key: key);

  final int targetSteps = 9000;
  final int targetDistance = 10;
  final int targetCalories = 1000;
  final int completedSteps;
  final double completedDistance;
  final double completedCalories;

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    _earnCoinsAndUpdateBalance();
  }

  Future<void> _earnCoinsAndUpdateBalance() async {
    final fitnessAppModel = ref.read(fitnessAppModelProvider);
    await fitnessAppModel.earnCoins(
      widget.completedSteps.toInt(),
      widget.completedDistance.toInt(),
    );
  }

  String getProgressString(int target, double completed) {
    if (completed >= target) {
      return 'Completed';
    } else {
      double progress = target - completed;
      String formattedProgress = progress.toStringAsFixed(2);
      return '$formattedProgress remaining';
    }
  }

  double getProgressValue(int target, double completed) {
    if (completed >= target) {
      return 1;
    } else {
      return completed / target;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fitnessAppModel = ref.read(fitnessAppModelProvider);
    final balanceFuture = fitnessAppModel.getBalance();

    return Scaffold(
      body: FutureBuilder<int>(
        future: balanceFuture,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final points = snapshot.data!;
            print("Updated Balance: $points Coins"); // Debugging output
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFA709A), Color(0xFFFEFEFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Text(
                      "Your Progress",
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    'assets/badges/bad5.png',
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
                          color: Colors.white,
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesome5Solid.coins,
                                color: Color.fromARGB(255, 231, 175, 7),
                                size: 32,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "$points Coins",
                                style: const TextStyle(
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
                              Text('Redeem'),
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
                    goal: '${widget.targetSteps} Steps',
                    reward: '100 Coins',
                    progress: getProgressString(
                        widget.targetSteps, widget.completedSteps.toDouble()),
                    progressValue: getProgressValue(
                        widget.targetSteps, widget.completedSteps.toDouble()),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ProgessContainer(
                    icon: MaterialCommunityIcons.map_marker_distance,
                    iconColor: const Color.fromARGB(255, 245, 0, 0),
                    goal: '${widget.targetDistance} Km',
                    reward: '150 Coins',
                    progress: getProgressString(
                        widget.targetDistance, widget.completedDistance),
                    progressValue: getProgressValue(
                        widget.targetDistance, widget.completedDistance),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ProgessContainer(
                    icon: FontAwesome.heartbeat,
                    iconColor: const Color.fromARGB(255, 255, 217, 0),
                    goal: '${widget.targetCalories} Cal',
                    reward: '50 Coins',
                    progress: getProgressString(
                        widget.targetCalories, widget.completedCalories),
                    progressValue: getProgressValue(
                        widget.targetCalories, widget.completedCalories),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
