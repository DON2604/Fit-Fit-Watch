import 'dart:io';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void rain() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String age = prefs.getString('age') ?? '';
  String disease = prefs.getString('disease') ?? '';
  String gender = prefs.getString('gender') ?? '';
  gender=(gender=='male')?"1":"0";
  



  
  final directory = await getApplicationDocumentsDirectory();
  final pathToFile = '${directory.path}/classifier.json';

  final file = File(pathToFile);
  final encodedModel = await file.readAsString();

   
  final model = LogisticRegressor.fromJson(encodedModel);


  final prediction = model.predict(DataFrame([
    ["Age", "Gender", "Heart Rate","Diseases", "Outside Temperature (°C)"],
    [age, 1, 110,2, 22],
  ]));



  print(prediction.header);
  print(prediction.rows);
}