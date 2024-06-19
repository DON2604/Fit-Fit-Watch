import 'dart:io';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';

void rain() async {

  
  final directory = await getApplicationDocumentsDirectory();
  final pathToFile = '${directory.path}/classifier.json';





  final file = File(pathToFile);
  final encodedModel = await file.readAsString();

   
  final model = LogisticRegressor.fromJson(encodedModel);


  final prediction = model.predict(DataFrame([
    ["Age", "Gender", "Heart Rate","Diseases", "Outside Temperature (°C)"],
    [90, 1, 110,2, 22],
  ]));



  print(prediction.header);
  print(prediction.rows);
}