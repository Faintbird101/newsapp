// lib/database_helper.dart
import 'dart:io';
import 'package:mohoro/common.libs.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "news.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int newVersion) async {
    // Execute the schema SQL to create the articles table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS articles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        source TEXT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT
      );
    ''');
  }
  Future<void> saveArticles(List<ArticleModel> articles) async {
    final db = await database;

    await db!.transaction((txn) async {
      for (var article in articles) {
        await txn.insert(
          'articles',
          article.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<ArticleModel>> getArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('articles');

    return List.generate(maps.length, (i) {
      return ArticleModel.fromJson(maps[i]);
    });
  }
}
