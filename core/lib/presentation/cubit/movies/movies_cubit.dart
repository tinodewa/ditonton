// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:core/common/failure.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'movies_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MoviesListCubit({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MoviesEmpty());

  Future<void> getMoviesList() async {
    emit(MoviesLoading());
    final resultMoviesList = await Future.wait<Either<Failure, List<Movie>>>([
      getNowPlayingMovies.execute(),
      getPopularMovies.execute(),
      getTopRatedMovies.execute(),
    ]);
    final finalResultMoviesList = resultMoviesList
        .map<List<Movie>>(
          (movies) => movies.fold(
            (failure) => [],
            (movie) => movie,
          ),
        )
        .toList();
    emit(_moviesListState(finalResultMoviesList));
  }

  MoviesListState _moviesListState(List<List<Movie>> resultMoviesList) {
    if (resultMoviesList.where((movies) => movies.isNotEmpty).isEmpty ||
        resultMoviesList.length < 3) {
      return MoviesError('Error');
    }
    return MovieListHasData(
      resultMoviesList.elementAt(0),
      resultMoviesList.elementAt(1),
      resultMoviesList.elementAt(2),
    );
  }
}

class MoviesPopularCubit extends Cubit<MoviesListState> {
  final GetPopularMovies getPopularMovies;

  MoviesPopularCubit({
    required this.getPopularMovies,
  }) : super(MoviesEmpty());

  Future<void> getMoviesPopular() async {
    emit(MoviesLoading());
    final resultMoviesPopular =
        await Future.wait<Either<Failure, List<Movie>>>([
      getPopularMovies.execute(),
    ]);

    final finalResultMoviesPopular = resultMoviesPopular
        .map<List<Movie>>(
          (movies) => movies.fold(
            (failure) => [],
            (movie) => movie,
          ),
        )
        .toList();
    emit(_moviesPopularState(finalResultMoviesPopular.first));
  }

  MoviesListState _moviesPopularState(List<Movie> resultMoviesPopular) {
    if (resultMoviesPopular.isEmpty) {
      return MoviesError('Error');
    }
    return MoviesPopularHasData(resultMoviesPopular);
  }
}

class MoviesTopRatedCubit extends Cubit<MoviesListState> {
  final GetTopRatedMovies getTopRatedMovies;

  MoviesTopRatedCubit({
    required this.getTopRatedMovies,
  }) : super(MoviesEmpty());

  Future<void> getMoviesTopRated() async {
    emit(MoviesLoading());
    final resultMoviesTopRated =
        await Future.wait<Either<Failure, List<Movie>>>([
      getTopRatedMovies.execute(),
    ]);
    final finalResultMoviesTopRated = resultMoviesTopRated
        .map<List<Movie>>(
          (movies) => movies.fold(
            (failure) => [],
            (movie) => movie,
          ),
        )
        .toList();
    emit(_moviesListState(finalResultMoviesTopRated.first));
  }

  MoviesListState _moviesListState(List<Movie> resultMoviesTopRated) {
    if (resultMoviesTopRated.isEmpty) {
      return MoviesError('Error');
    }
    return MoviesTopRatedHasData(resultMoviesTopRated);
  }
}

class MoviesWatchlistCubit extends Cubit<MoviesListState> {
  final GetWatchlistMovies getWatchlistMovies;

  MoviesWatchlistCubit({
    required this.getWatchlistMovies,
  }) : super(MoviesEmpty());

  Future<void> getMoviesWatchlist() async {
    emit(MoviesLoading());
    final resultMoviesWatchlist =
        await Future.wait<Either<Failure, List<Movie>>>([
      getWatchlistMovies.execute(),
    ]);

    final finalResultMoviesWatchlist = resultMoviesWatchlist
        .map<List<Movie>>(
          (movies) => movies.fold(
            (failure) => [],
            (movie) => movie,
          ),
        )
        .toList();
    emit(_moviesWatchlistState(finalResultMoviesWatchlist.first));
  }

  MoviesListState _moviesWatchlistState(List<Movie> resultMoviesWatchlist) {
    if (resultMoviesWatchlist.isEmpty) {
      return MoviesError('Error');
    }
    return MoviesWatchlistHasData(resultMoviesWatchlist);
  }
}
