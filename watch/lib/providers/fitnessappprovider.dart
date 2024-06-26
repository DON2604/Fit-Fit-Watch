import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch/model/FitnessAppModel.dart';


final fitnessAppModelProvider = ChangeNotifierProvider((ref) => FitnessAppModel());
