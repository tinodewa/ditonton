// ignore_for_file: prefer_const_constructors_in_immutables, override_on_non_overriding_member, prefer_const_literals_to_create_immutables

part of 'movies_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  MovieDetailState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.movieRecommendations,
    required this.movieRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });
  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  //tambahkan juga factory contructor untuk membuat initial state nya
  factory MovieDetailState.initial() => MovieDetailState(
        movieDetail: null,
        movieDetailState: RequestState.Empty,
        movieRecommendations: [],
        movieRecommendationsState: RequestState.Empty,
        message: '',
        watchlistMessage: '',
        isAddedToWatchlist: false,
      );

  @override
  List<Object?> get props => [
        movieDetail,
        movieDetailState,
        movieRecommendations,
        movieRecommendationsState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
