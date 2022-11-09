import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';

class GetTvseriesDetail {
  final TvseriesRepository repository;

  GetTvseriesDetail(this.repository);

  Future<Either<Failure, TvseriesDetail>> execute(int id) {
    return repository.getTvseriesDetail(id);
  }
}
