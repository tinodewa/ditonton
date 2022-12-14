import 'package:core/core.dart';
import '../../data/datasources/db/database_helper.dart';
import '../../data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlistMovies(MovieTable movie);
  Future<String> removeWatchlistMovies(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlistMovie(movie);
      return 'Added movies to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovies(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlistMovie(movie);
      return 'Removed movies from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
