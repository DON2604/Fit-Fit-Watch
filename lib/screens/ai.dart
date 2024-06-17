import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() {
    return _AiScreen();
  }
}

class _AiScreen extends State<AiScreen> {
  String? name = '';
  int heart = 0;

  @override
  void initState() {
    super.initState();
    _loadName();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _loadName();
    });
  }

  Future<void> _loadName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(Uri.parse('http://192.168.0.101:5000/heartbeat'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          name = prefs.getString('name') ?? '';
          heart = data['heartbeat'];
        });
      } else {
        throw Exception('Failed to load steps');
      }
    } catch (e) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        name = prefs.getString('name') ?? '';
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: GoogleFonts.montserrat(fontSize: 29, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Welcome to AI based realtime",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "health checkup system.",
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
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
                  color: Color.fromARGB(225, 255, 255, 255),
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Status",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
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
                                      "Watch Status: Active",
                                      style: GoogleFonts.roboto(fontSize: 14),
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
                                fontSize: 14,
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
                                  "$heart BPM",
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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.warning, color: Colors.red),
                            const SizedBox(width: 8),
                            Text(
                              "AI Analysis: Elevated heart rate detected.",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Recommendation: Please take a few deep breaths and try to relax. If the elevated heart rate persists, consult a healthcare professional.",
                          style: GoogleFonts.roboto(fontSize: 14),
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
