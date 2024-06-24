import 'package:flutter/material.dart';
import 'package:watch/widgets/col_data.dart';
import 'package:watch/widgets/gridder.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(114, 87, 233, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const ColData(),
          ),
          const Expanded(
            child: Gridder(),
          ),
        ],
      ),
    );
  }


}
