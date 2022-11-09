import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/core.dart';

abstract class TvseriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvseries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvseries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvseries();
  Future<Either<Failure, TvseriesDetail>> getTvseriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvseriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvseries(String query);
  Future<Either<Failure, String>> saveWatchlistTvseries(TvseriesDetail movie);
  Future<Either<Failure, String>> removeWatchlistTvseries(TvseriesDetail movie);
  Future<bool> isAddedToWatchlistTvseries(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvseries();
}
