import 'dart:async';

import 'package:core/common/encrypt.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../models/movie_table.dart';
import '../../models/tvseries_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlistMovie = 'watchlistMovie';
  static const String _tblWatchlistTvseries = 'watchlistTvseries';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
      password: encrypt('Your secure password...'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblWatchlistMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tblWatchlistTvseries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      )
    ''');
  }

  //movies
  Future<int> insertWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlistMovie, movie.toJson());
  }

  Future<int> removeWatchlistMovie(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistMovie,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistMovie);

    return results;
  }

  //tvseries
  Future<int> insertWatchlisTvseries(TvseriesTable tvseries) async {
    final db = await database;
    return await db!.insert(_tblWatchlistTvseries, tvseries.toJson());
  }

  Future<int> removeWatchlistTvseries(TvseriesTable tvseries) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlistTvseries,
      where: 'id = ?',
      whereArgs: [tvseries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvseriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlistTvseries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvseries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblWatchlistTvseries);

    return results;
  }
}
