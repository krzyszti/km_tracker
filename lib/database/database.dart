import 'dart:io';
import 'package:km_tracker/repository/training_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'app.db');
    return await openDatabase(path, version: 1, onOpen: (db) async {},
        onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE training(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  date TEXT,
                  distance TEXT
                )
            ''');
    });
  }

  Future<List<TrainingEntity>> allTrainings() async {
    final Database db = await database;
    final res  = await db.query('training', orderBy: '-id');
    if (res.isEmpty) {
      return [];
    }
    return res.map((training) => TrainingEntity.fromJson(training)).toList();
  }

  Future<void> createTraining(TrainingEntity training) async {
    final Database db = await database;
    db.insert('training', training.toJson());
  }
}
