// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesHasData extends SearchState {
  final List<Movie> result;

  SearchMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class SearchTvseriesHasData extends SearchState {
  final List<TvSeries> result;

  SearchTvseriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
