// ignore_for_file: prefer_const_constructors_in_immutables

part of 'movies_detail_bloc.dart';

abstract class MoviesDetailEvent extends Equatable {
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetMoviesDetail extends MoviesDetailEvent {
  final int id;

  OnGetMoviesDetail(this.id);

  @override
  List<Object> get props => [id];
}

class GetWatchlistStatus extends MoviesDetailEvent {
  final int id;

  GetWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMoviesWatchlist extends MoviesDetailEvent {
  final MovieDetail movieDetail;

  AddMoviesWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveMoviesWatchlist extends MoviesDetailEvent {
  final MovieDetail movieDetail;

  RemoveMoviesWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
