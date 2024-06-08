import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class StepGauge extends StatefulWidget {
  const StepGauge({super.key});
  @override
  State<StatefulWidget> createState() {
    return _StepGauge();
  }
}

class _StepGauge extends State<StepGauge> {
  @override
  Widget build(context) {
    return Align(
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
    );
  }
}
