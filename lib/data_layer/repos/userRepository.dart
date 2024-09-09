// ------------------------------------------------ handle crud operations for (only user) ------------------------------------------------

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  UserRepository._internal();

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
       // Create users table
      await db.execute(
        '''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT,
          email TEXT,
          password TEXT,
          gender TEXT,
          weight TEXT,
          waterGoalPercentage TEXT,
          currentWaterPercentage INTEGER DEFAULT 0
        )
        ''',
      );
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

  Future<int> addUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // login (get user by username and password)
  Future<User?> getUserByUsernamePassword(String? username,String? password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: "username = ? AND password = ?",
      whereArgs: [username,password],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      print("no user with this coords");
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> updateUserGender(int userid, String newGender) async {
    final db = await database;
    return await db.update(
      'users',
      {'gender': newGender},
      where: "id = ?",
      whereArgs: [userid],
    );
  }

  Future<int> updateUserDailyGoal(int userid, String newDailyGoal) async {
    final db = await database;
    return await db.update(
      'users',
      {'waterGoalPercentage': newDailyGoal},
      where: "id = ?",
      whereArgs: [userid],
    );
  }

   Future<int> getPercentageWaterByUserId(int userId) async {
  final db = await database;
  // Properly format the SQL query with single quotes around the date strings
  List<Map<String, dynamic>> result = await db.rawQuery(
    "SELECT currentWaterPercentage "
    "FROM users "
    "WHERE id = ? ",
    [userId]
  );
  int waterPercentage = result[0]['currentWaterPercentage'] != null ? (result[0]['currentWaterPercentage']).toInt() : 0; // default to 0 if null
  return waterPercentage;
  }

  Future<int> updateUserWeight(int userid, String newWeight) async {
    final db = await database;
    return await db.update(
      'users',
      {'weight': newWeight},
      where: "id = ?",
      whereArgs: [userid],
    );
  }

  Future<int> updateUserCurrentPercentage(int userid, int newPercentage) async {
    final db = await database;
    return await db.update(
      'users',
      {'currentWaterPercentage': newPercentage},
      where: "id = ?",
      whereArgs: [userid],
    );
  }

  Future<int> deleteUser(int userid) async {
    final db = await database;
    return await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [userid],
    );
  }

  Future<User?> getLastUser() async {
    final db = await database;
    final maps = await db.query(
      'users',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
