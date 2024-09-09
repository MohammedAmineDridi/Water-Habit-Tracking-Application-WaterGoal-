// ------------------------------------------------ handle crud operations for (only user) ------------------------------------------------

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/accomplishement.dart';


class AccomplishementRepository {
  static final AccomplishementRepository _instance = AccomplishementRepository._internal();
  factory AccomplishementRepository() => _instance;
  AccomplishementRepository._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'watergoal.db'),
      onCreate: (db, version) async {
        // Create accomplishments table
        await db.execute(
          '''
          CREATE TABLE accomplishements(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER,
            percentageWaterValue INTEGER,
            percentageDate TEXT,
            FOREIGN KEY (userId) REFERENCES users(id)
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<List<Accomplishement>> getAllAccomplishement() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('accomplishements');
    return List.generate(maps.length, (i) {
      return Accomplishement.fromMap(maps[i]);
    });
  }

  Future<int> addAccomplishment(Accomplishement accomplishement) async {
    final db = await database;
    return await db.insert('accomplishements', accomplishement.toMap());
  }
  // get list of accomplishement by userId between 2 dates (from,to)

  Future<List<Accomplishement>> getAccomplishementByuserIdBetweenDates(int userId,String from,String to) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
    'accomplishements',where: "userId = ? AND percentageDate BETWEEN ? AND ?",
    whereArgs: [userId,from,to],
    );
    return List.generate(maps.length, (i) {
      return Accomplishement.fromMap(maps[i]);
    });
  }

  // get average of accomplishements by userId between 2 dates

  Future<int> getAverageAccomplishementsUser(int userId, String from, String to) async {
  final db = await database;
  List<Map<String, dynamic>> result = await db.rawQuery(
    "SELECT AVG(percentageWaterValue) AS waterPercentageAverage "
    "FROM accomplishements "
    "WHERE userId = ? "
    "AND percentageDate BETWEEN ? AND ?",
    [userId, from, to]
  );
  int averageAccomplishement = (result[0]['waterPercentageAverage'] ?? 0).toInt();
  return averageAccomplishement;
  }

}
