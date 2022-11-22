// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'tvseries_state.dart';

class TvseriesListCubit extends Cubit<TvseriesListState> {
  final GetNowPlayingTvseries getNowPlayingTvseries;
  final GetPopularTvseries getPopularTvseries;
  final GetTopRatedTvseries getTopRatedTvseries;

  TvseriesListCubit({
    required this.getNowPlayingTvseries,
    required this.getPopularTvseries,
    required this.getTopRatedTvseries,
  }) : super(TvseriesEmpty());

  Future<void> getTvseriesList() async {
    emit(TvseriesLoading());
    final resultTvseriesList =
        await Future.wait<Either<Failure, List<TvSeries>>>([
      getNowPlayingTvseries.execute(),
      getPopularTvseries.execute(),
      getTopRatedTvseries.execute(),
    ]);
    final finalResultTvseriesList = resultTvseriesList
        .map<List<TvSeries>>(
          (tvserieslist) => tvserieslist.fold(
            (failure) => [],
            (tvseries) => tvseries,
          ),
        )
        .toList();
    emit(_tvseriesListState(finalResultTvseriesList));
  }

  TvseriesListState _tvseriesListState(
      List<List<TvSeries>> resultTvseriesList) {
    if (resultTvseriesList.where((tvseries) => tvseries.isNotEmpty).isEmpty ||
        resultTvseriesList.length < 3) {
      return TvseriesError('Error');
    }
    return TvseriesListHasData(
      resultTvseriesList.elementAt(0),
      resultTvseriesList.elementAt(1),
      resultTvseriesList.elementAt(2),
    );
  }
}

class TvseriesPopularCubit extends Cubit<TvseriesListState> {
  final GetPopularTvseries getPopularTvseries;

  TvseriesPopularCubit({
    required this.getPopularTvseries,
  }) : super(TvseriesEmpty());

  Future<void> getTvseriesPopular() async {
    emit(TvseriesLoading());
    final resultTvseriesPopular =
        await Future.wait<Either<Failure, List<TvSeries>>>([
      getPopularTvseries.execute(),
    ]);

    final finalResultTvseriesPopular = resultTvseriesPopular
        .map<List<TvSeries>>(
          (tvserieslist) => tvserieslist.fold(
            (failure) => [],
            (tvseries) => tvseries,
          ),
        )
        .toList();
    emit(_tvseriesPopularState(finalResultTvseriesPopular.first));
  }

  TvseriesListState _tvseriesPopularState(
      List<TvSeries> resultTvseriesPopular) {
    if (resultTvseriesPopular.isEmpty) {
      return TvseriesError('Error');
    }
    return TvseriesPopularHasData(resultTvseriesPopular);
  }
}

class TvseriesTopRatedCubit extends Cubit<TvseriesListState> {
  final GetTopRatedTvseries getTopRatedTvseries;

  TvseriesTopRatedCubit({
    required this.getTopRatedTvseries,
  }) : super(TvseriesEmpty());

  Future<void> getTvseriesTopRated() async {
    emit(TvseriesLoading());
    final resultTvseriesTopRated =
        await Future.wait<Either<Failure, List<TvSeries>>>([
      getTopRatedTvseries.execute(),
    ]);
    final finalResultTvseriesTopRated = resultTvseriesTopRated
        .map<List<TvSeries>>(
          (tvserieslist) => tvserieslist.fold(
            (failure) => [],
            (tvseries) => tvseries,
          ),
        )
        .toList();
    emit(_tvseriesListState(finalResultTvseriesTopRated.first));
  }

  TvseriesListState _tvseriesListState(List<TvSeries> resultTvseriesTopRated) {
    if (resultTvseriesTopRated.isEmpty) {
      return TvseriesError('Error');
    }
    return TvseriesTopRatedHasData(resultTvseriesTopRated);
  }
}

class TvseriesWatchlistCubit extends Cubit<TvseriesListState> {
  final GetWatchlistTvseries getWatchlistTvseries;

  TvseriesWatchlistCubit({
    required this.getWatchlistTvseries,
  }) : super(TvseriesEmpty());

  Future<void> getTvseriesWatchlist() async {
    emit(TvseriesLoading());
    final resultTvseriesWatchlist =
        await Future.wait<Either<Failure, List<TvSeries>>>([
      getWatchlistTvseries.execute(),
    ]);

    final finalResultTvseriesWatchlist = resultTvseriesWatchlist
        .map<List<TvSeries>>(
          (tvserieslist) => tvserieslist.fold(
            (failure) => [],
            (tvseries) => tvseries,
          ),
        )
        .toList();
    emit(_tvseriesWatchlistState(finalResultTvseriesWatchlist.first));
  }

  TvseriesListState _tvseriesWatchlistState(
      List<TvSeries> resultTvseriesWatchlist) {
    if (resultTvseriesWatchlist.isEmpty) {
      return TvseriesError('Error');
    }
    return TvseriesWatchlistHasData(resultTvseriesWatchlist);
  }
}
