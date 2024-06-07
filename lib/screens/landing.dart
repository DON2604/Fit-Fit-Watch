import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          "39°C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Text(
                          "Exercise",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 14.0),
                        child: Icon(
                          Icons.watch,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.75,
                    child: Stack(
                      children: [
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              radiusFactor: 0.5,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.1,
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              labelFormat: '',
                              minorTickStyle: const MinorTickStyle(length: 0),
                              pointers: const <GaugePointer>[
                                RangePointer(
                                  value: 50,
                                  width: 0.1,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  gradient: SweepGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 230, 145, 172),
                                      Color.fromARGB(255, 200, 133, 223)
                                    ],
                                    stops: <double>[0.25, 0.75],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '9999',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Steps',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
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
                            padding: EdgeInsets.only(left: 58.0),
                            child: Text(
                              "9999",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Padding(
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
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "80.0 km",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Padding(
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
                            padding: EdgeInsets.only(right: 58.0),
                            child: Text(
                              "0.0 Kcal",
                              style: TextStyle(
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
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: [
                  buildHealthCard(
                      'Steps',
                      '9999',
                      'Steps',
                      Icons.run_circle_outlined,
                      const Color.fromARGB(112, 255, 224, 178),
                      Colors.orange),
                  buildHealthCard(
                    'Heart rate', 
                    '120', 
                    'bpm',
                      Icons.favorite_border,
                       const Color.fromARGB(112, 187, 222, 251), 
                       Colors.blue),
                  buildHealthCard(
                    'Sleep', 
                    '7.5', 
                    'hours',
                     Icons.nights_stay,
                      Color.fromARGB(112, 178, 235, 242),
                      Colors.cyan),
                  buildHealthCard(
                      'Calories',
                      '0.0',
                      'Kcal',
                      Icons.local_fire_department,
                      Color.fromARGB(112, 255, 236, 179),
                      Colors.amber),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHealthCard(String title, String value, String unit, IconData icon,
      Color backgroundColor, Color iconColor) {
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
