import 'package:flutter/material.dart';
import 'package:watch/widgets/step_gauge.dart';

class ColData extends StatefulWidget {
  const ColData({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ColData();
  }
}

class _ColData extends State<ColData> {
  @override
  Widget build(context) {
    return const Column(
              children: [
                Padding(
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
                  child: StepGauge(),
                ),
                IntrinsicHeight(
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
                SizedBox(height: 25)
              ],
            );
  }
}