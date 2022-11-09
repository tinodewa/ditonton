import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';

class RemoveWatchlistTvseries {
  final TvseriesRepository repository;

  RemoveWatchlistTvseries(this.repository);

  Future<Either<Failure, String>> execute(TvseriesDetail tvseriesDetail) {
    return repository.removeWatchlistTvseries(tvseriesDetail);
  }
}
