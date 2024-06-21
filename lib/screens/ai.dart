import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch/backend/aipro2.dart';
import 'package:watch/data/rec.dart';
import 'package:watch/providers/heart_rate_provider.dart';

class AiScreen extends ConsumerStatefulWidget {
  const AiScreen({super.key});

  @override
  ConsumerState<AiScreen> createState() {
    return _AiScreen();
  }
}

class _AiScreen extends ConsumerState<AiScreen> {
  String? name = '';
  dynamic predictionResult = 'Crunching your Data...';
  String res = 'Processing...';
  String prevpred = '';
  var dynamicIcon = const Icon(Icons.warning, color: Colors.red);

  @override
  void initState() {
    super.initState();
    _loadName();
    _fetchPrediction();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchPrediction();
    });
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
    });
  }

  Future<void> _fetchPrediction() async {
    try {
      List prediction = await rain();
      setState(() {
        predictionResult =
            prediction.isNotEmpty ? prediction[0] : 'No prediction available';
        if (predictionResult == 0.0) {
          predictionResult = "HEALTH STATUS NORMAL";
        } else {
          predictionResult = "ABNORMAL HEALTH STATUS DETECTED";
        }
        List<String> selectedRecommendations =
            recommendations[predictionResult]!;

        if (predictionResult != prevpred) {
          res = selectedRecommendations[
              Random().nextInt(selectedRecommendations.length)];
          prevpred = predictionResult;
        }
      });
    } catch (e) {
      setState(() {
        predictionResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final heartRateState = ref.watch(heartRateProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 149, 234, 244), // Light Blue
              Color(0xFFF5F5F5), // Light Grey
            ],
            stops: [0.0, 0.7],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi $name!',
                        style: GoogleFonts.montserrat(
                            fontSize: 29, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Welcome to AI based realtime",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "health checkup system.",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/ai/ai1.gif",
                    width: 155,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  color: const Color.fromARGB(225, 255, 255, 255),
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12, left: 16.0, right: 16.0, bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Status",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Image.asset(
                              "assets/ai/watch.png",
                              width: 120,
                            ),
                            const SizedBox(width: 55),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.watch),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Status: ",
                                      style: GoogleFonts.roboto(fontSize: 14),
                                    ),
                                    Text(
                                      heartRateState.wastat,
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: heartRateState.statcol,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.battery_full),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Battery: 85%",
                                      style: GoogleFonts.roboto(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Health Data:",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Current Heart Rate:",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                                Text(
                                  heartRateState.hrtstat,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Blood Pressure:",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                                Text(
                                  "120/80 mmHg",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Oxygen Saturation:",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                                Text(
                                  "98%",
                                  style: GoogleFonts.roboto(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            Text(
                              "AI Analysis:",
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (predictionResult ==
                                    "ABNORMAL HEALTH STATUS DETECTED")
                                ? const Icon(Icons.warning, color: Colors.red)
                                : const Icon(FontAwesome.check_circle,
                                    color: Colors.green),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              predictionResult,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: predictionResult ==
                                        "ABNORMAL HEALTH STATUS DETECTED"
                                    ? const Color.fromARGB(255, 154, 14, 4)
                                    : const Color.fromARGB(255, 5, 116, 8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Recommendations:",
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              res,
                              style: GoogleFonts.roboto(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
