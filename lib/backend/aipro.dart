import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

void rain() async {

  final rawCsvContent = await rootBundle.loadString('lib/data/housing.csv');
  print(rawCsvContent);

  final samples = DataFrame.fromRawCsv(rawCsvContent, fieldDelimiter: ' ');
  print(samples.header);

  const targetName = 'col_13';

  final splits = splitData(samples, [0.8]);

  final trainData = splits[0];

  final testData = splits[1];
  final model = LinearRegressor(trainData, targetName);

  final error = model.assess(testData, MetricType.mape);
    
  model.saveAsJson('housing_model.json');

}