// ignore_for_file: prefer_const_constructors_in_immutables

part of 'movies_cubit.dart';

@immutable
abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MoviesListState {}

class MoviesLoading extends MoviesListState {}

class MoviesError extends MoviesListState {
  final String message;

  MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasData extends MoviesListState {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  MovieListHasData(
    this.nowPlayingMovies,
    this.popularMovies,
    this.topRatedMovies,
  );

  @override
  List<Object> get props => [
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
      ];
}

class MoviesPopularHasData extends MoviesListState {
  final List<Movie> popularMovies;

  MoviesPopularHasData(
    this.popularMovies,
  );

  @override
  List<Object> get props => [
        popularMovies,
      ];
}

class MoviesNowPlayingHasData extends MoviesListState {
  final List<Movie> nowPlayingMovies;

  MoviesNowPlayingHasData(
    this.nowPlayingMovies,
  );

  @override
  List<Object> get props => [
        nowPlayingMovies,
      ];
}

class MoviesTopRatedHasData extends MoviesListState {
  final List<Movie> topRatedMovies;

  MoviesTopRatedHasData(
    this.topRatedMovies,
  );

  @override
  List<Object> get props => [
        topRatedMovies,
      ];
}

class MoviesWatchlistHasData extends MoviesListState {
  final List<Movie> watchlistMovies;

  MoviesWatchlistHasData(
    this.watchlistMovies,
  );

  @override
  List<Object> get props => [
        watchlistMovies,
      ];
}
