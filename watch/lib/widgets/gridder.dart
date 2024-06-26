import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Gridder extends StatefulWidget {
  const Gridder({
    super.key,
    required this.totalDistanceToday,
    required this.totalStepsToday,
    required this.totalCaloriesToday,
  });

  final double totalDistanceToday;
  final int totalStepsToday;
  final double totalCaloriesToday;

  @override
  State<Gridder> createState() {
    return _Gridder();
  }
}

class _Gridder extends State<Gridder> {
  late final String? ip;
  int heart = 0;

  @override
  void initState() {
    super.initState();
    ip = dotenv.env["IP"];
    if (ip != null) {
      _fetchBeat();
      Timer.periodic(const Duration(seconds: 2), (timer) {
        _fetchBeat();
      });
    }
  }

  Future<void> _fetchBeat() async {
    if (ip == null) return;
    try {
      final response = await http.get(Uri.parse('http://$ip/heartbeat'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          heart = data['heartbeat'];
        });
      } else {
        throw Exception('Failed to load heartbeat');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: [
          buildHealthCard(
            'Steps',
            widget.totalStepsToday.toString(),
            'Steps',
            Icons.run_circle_outlined,
            const Color.fromARGB(112, 255, 224, 178),
            Colors.orange,
          ),
          buildHealthCard(
            'Heart rate',
            heart.toString(),
            'bpm',
            Icons.favorite_border,
            const Color.fromARGB(112, 187, 222, 251),
            Colors.blue,
          ),
          buildHealthCard(
            'Distance',
            widget.totalDistanceToday.toStringAsFixed(2),
            'km',
            Icons.directions_walk,
            const Color.fromARGB(112, 178, 235, 242),
            Colors.cyan,
          ),
          buildHealthCard(
            'Calories',
            widget.totalCaloriesToday.toStringAsFixed(2),
            'Kcal',
            Icons.local_fire_department,
            const Color.fromARGB(112, 255, 236, 179),
            Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget buildHealthCard(
    String title,
    String value,
    String unit,
    IconData icon,
    Color backgroundColor,
    Color iconColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              unit,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
