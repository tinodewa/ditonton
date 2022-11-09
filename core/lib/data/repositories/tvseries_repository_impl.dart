// ignore_for_file: use_rethrow_when_possible

import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/data/models/tvseries_table.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';

class TvseriesRepositoryImpl implements TvseriesRepository {
  final TvseriesRemoteDataSource remoteDataSource;
  final TvseriesLocalDataSource localDataSource;

  TvseriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvseries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTvseries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvseriesDetail>> getTvseriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvseriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvseriesRecommendations(
    int id,
  ) async {
    try {
      final result = await remoteDataSource.getTvseriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvseries() async {
    try {
      final result = await remoteDataSource.getPopularTvseries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvseries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvseries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvseries(String query) async {
    try {
      final result = await remoteDataSource.searchTvseries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTvseries(
      TvseriesDetail tvseries) async {
    try {
      final result = await localDataSource
          .insertWatchlistTvseries(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTvseries(
      TvseriesDetail tvseries) async {
    try {
      final result = await localDataSource
          .removeWatchlistTvseries(TvseriesTable.fromEntity(tvseries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlistTvseries(int id) async {
    final result = await localDataSource.getTvseriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvseries() async {
    final result = await localDataSource.getWatchlistTvseries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
