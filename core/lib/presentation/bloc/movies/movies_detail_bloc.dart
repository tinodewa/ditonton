// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';

part 'movies_detail_event.dart';
part 'movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatusMovie _getWatchListStatusMovie;
  final SaveWatchlistMovies _saveWatchlistMovies;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MoviesDetailBloc(
      this._getMovieDetail,
      this._getMovieRecommendations,
      this._getWatchListStatusMovie,
      this._saveWatchlistMovies,
      this._removeWatchlistMovie)
      : super(MovieDetailState.initial()) {
    on<OnGetMoviesDetail>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.Loading));

      final resultDetail = await _getMovieDetail.execute(event.id);
      final resultRecommendation =
          await _getMovieRecommendations.execute(event.id);

      resultDetail.fold(
        (failure) async {
          emit(
            state.copyWith(
              movieDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (movie) async {
          emit(
            state.copyWith(
              movieRecommendationsState: RequestState.Loading,
              movieDetail: movie,
              movieDetailState: RequestState.Loaded,
              message: '',
            ),
          );
          resultRecommendation.fold(
            (failure) {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            },
            (movies) {
              emit(
                state.copyWith(
                  movieRecommendationsState: RequestState.Loaded,
                  movieRecommendations: movies,
                  message: '',
                ),
              );
            },
          );
        },
      );
    });
    on<GetWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatusMovie.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
    on<AddMoviesWatchlist>((event, emit) async {
      final result = await _saveWatchlistMovies.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(GetWatchlistStatus(event.movieDetail.id));
    });
    on<RemoveMoviesWatchlist>((event, emit) async {
      final result = await _removeWatchlistMovie.execute(event.movieDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(GetWatchlistStatus(event.movieDetail.id));
    });
  }
}
