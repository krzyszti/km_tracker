import 'dart:async';
import 'dart:core';

import 'package:km_tracker/database/database.dart';

import 'training_entity.dart';

class TrainingsRepository {
  final DBProvider _database = DBProvider.db;
  TrainingsRepository();

  Future<List<TrainingEntity>> loadTrainings() async {
    return await _database.allTrainings();
  }

  Future<void> saveTraining(TrainingEntity training) async {
    _database.createTraining(training);
  }
}
