import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Color.fromARGB(255, 175, 175, 175),
             Color.fromARGB(255, 223, 223, 223)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.7],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_none,
                color: Color.fromARGB(255, 150, 149, 149), // Dark grey color for the icon
                size: 100.0,
              ),
             SizedBox(height: 20.0), // Space between the icon and text
              Text(
                'No notification to display',
                style: TextStyle(
                  color: Color.fromARGB(255, 119, 119, 119), // Dark grey color for the text
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
