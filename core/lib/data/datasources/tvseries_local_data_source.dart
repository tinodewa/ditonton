import 'package:core/core.dart';
import '../../data/datasources/db/database_helper.dart';
import '../../data/models/tvseries_table.dart';

abstract class TvseriesLocalDataSource {
  Future<String> insertWatchlistTvseries(TvseriesTable tvseries);
  Future<String> removeWatchlistTvseries(TvseriesTable tvseries);
  Future<TvseriesTable?> getTvseriesById(int id);
  Future<List<TvseriesTable>> getWatchlistTvseries();
}

class TvseriesLocalDataSourceImpl implements TvseriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvseriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlistTvseries(TvseriesTable tvseries) async {
    try {
      await databaseHelper.insertWatchlisTvseries(tvseries);
      return 'Added tv series to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvseries(TvseriesTable tvseries) async {
    try {
      await databaseHelper.removeWatchlistTvseries(tvseries);
      return 'Removed tv series from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvseriesTable?> getTvseriesById(int id) async {
    final result = await databaseHelper.getTvseriesById(id);
    if (result != null) {
      return TvseriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvseriesTable>> getWatchlistTvseries() async {
    final result = await databaseHelper.getWatchlistTvseries();
    return result.map((data) => TvseriesTable.fromMap(data)).toList();
  }
}
