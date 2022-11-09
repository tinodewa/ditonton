import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:flutter/material.dart';

class TvseriesListNotifier extends ChangeNotifier {
  var _nowPlayingTvseries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvseries => _nowPlayingTvseries;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvseries = <TvSeries>[];
  List<TvSeries> get popularTvseries => _popularTvseries;

  RequestState _popularTvseriesState = RequestState.Empty;
  RequestState get popularTvseriesState => _popularTvseriesState;

  var _topRatedTvseries = <TvSeries>[];
  List<TvSeries> get topRatedTvseries => _topRatedTvseries;

  RequestState _topRatedTvseriesState = RequestState.Empty;
  RequestState get topRatedTvseriesState => _topRatedTvseriesState;

  String _message = '';
  String get message => _message;

  TvseriesListNotifier({
    required this.getNowPlayingTvseries,
    required this.getPopularTvseries,
    required this.getTopRatedTvseries,
  });

  final GetNowPlayingTvseries getNowPlayingTvseries;
  final GetPopularTvseries getPopularTvseries;
  final GetTopRatedTvseries getTopRatedTvseries;

  Future<void> fetchNowPlayingTvseries() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvseries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvseries() async {
    _popularTvseriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvseries.execute();
    result.fold(
      (failure) {
        _popularTvseriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _popularTvseriesState = RequestState.Loaded;
        _popularTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvseries() async {
    _topRatedTvseriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvseries.execute();
    result.fold(
      (failure) {
        _topRatedTvseriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _topRatedTvseriesState = RequestState.Loaded;
        _topRatedTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }
}
