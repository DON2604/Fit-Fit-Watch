import 'dart:io';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

Future<void> main() async {
  final dataFrame = await fromCsv('../data/datasets.csv');

  print('Loaded DataFrame:');
  print(dataFrame);

}
