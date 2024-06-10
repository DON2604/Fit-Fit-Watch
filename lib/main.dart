import 'package:flutter/material.dart';
import 'package:watch/screens/tabs.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: TabsScreen(),
        ),
      ),
    ),
  );
}
