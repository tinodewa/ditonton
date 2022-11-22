// ignore_for_file: prefer_const_constructors_in_immutables

part of 'tvseries_cubit.dart';

@immutable
abstract class TvseriesListState extends Equatable {
  const TvseriesListState();

  @override
  List<Object> get props => [];
}

class TvseriesEmpty extends TvseriesListState {}

class TvseriesLoading extends TvseriesListState {}

class TvseriesError extends TvseriesListState {
  final String message;

  TvseriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TvseriesListHasData extends TvseriesListState {
  final List<TvSeries> nowPlayingTvseries;
  final List<TvSeries> popularTvseries;
  final List<TvSeries> topRatedTvseries;

  TvseriesListHasData(
    this.nowPlayingTvseries,
    this.popularTvseries,
    this.topRatedTvseries,
  );

  @override
  List<Object> get props => [
        nowPlayingTvseries,
        popularTvseries,
        topRatedTvseries,
      ];
}

class TvseriesPopularHasData extends TvseriesListState {
  final List<TvSeries> popularTvseries;

  TvseriesPopularHasData(
    this.popularTvseries,
  );

  @override
  List<Object> get props => [
        popularTvseries,
      ];
}

class TvseriesNowPlayingHasData extends TvseriesListState {
  final List<TvSeries> nowPlayingTvseries;

  TvseriesNowPlayingHasData(
    this.nowPlayingTvseries,
  );

  @override
  List<Object> get props => [
        nowPlayingTvseries,
      ];
}

class TvseriesTopRatedHasData extends TvseriesListState {
  final List<TvSeries> topRatedTvseries;

  TvseriesTopRatedHasData(
    this.topRatedTvseries,
  );

  @override
  List<Object> get props => [
        topRatedTvseries,
      ];
}

class TvseriesDetailHasData extends TvseriesListState {
  final TvseriesDetail tvseriesDetail;

  TvseriesDetailHasData(
    this.tvseriesDetail,
  );

  @override
  List<Object> get props => [
        tvseriesDetail,
      ];
}

class TvseriesWatchlistHasData extends TvseriesListState {
  final List<TvSeries> watchlistTvseries;

  TvseriesWatchlistHasData(
    this.watchlistTvseries,
  );

  @override
  List<Object> get props => [
        watchlistTvseries,
      ];
}
