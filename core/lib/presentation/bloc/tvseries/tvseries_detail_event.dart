// ignore_for_file: prefer_const_constructors_in_immutables

part of 'tvseries_detail_bloc.dart';

abstract class TvseriesDetailEvent extends Equatable {
  const TvseriesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvseriesDetail extends TvseriesDetailEvent {
  final int id;

  OnGetTvseriesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class GetWatchlistStatus extends TvseriesDetailEvent {
  final int id;

  GetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvseriesWatchlist extends TvseriesDetailEvent {
  final TvseriesDetail tvseriesDetail;

  AddTvseriesWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}

class RemoveTvseriesWatchlist extends TvseriesDetailEvent {
  final TvseriesDetail tvseriesDetail;

  RemoveTvseriesWatchlist(this.tvseriesDetail);

  @override
  List<Object> get props => [tvseriesDetail];
}
