// ignore_for_file: prefer_const_constructors_in_immutables, override_on_non_overriding_member, prefer_const_literals_to_create_immutables

part of 'tvseries_detail_bloc.dart';

class TvseriesDetailState extends Equatable {
  final TvseriesDetail? tvseriesDetail;
  final RequestState tvseriesDetailState;
  final List<TvSeries> tvseriesRecommendations;
  final RequestState tvseriesRecommendationsState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;
  TvseriesDetailState({
    required this.tvseriesDetail,
    required this.tvseriesDetailState,
    required this.tvseriesRecommendations,
    required this.tvseriesRecommendationsState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });
  TvseriesDetailState copyWith({
    TvseriesDetail? tvseriesDetail,
    RequestState? tvseriesDetailState,
    List<TvSeries>? tvseriesRecommendations,
    RequestState? tvseriesRecommendationsState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvseriesDetailState(
      tvseriesDetail: tvseriesDetail ?? this.tvseriesDetail,
      tvseriesDetailState: tvseriesDetailState ?? this.tvseriesDetailState,
      tvseriesRecommendations:
          tvseriesRecommendations ?? this.tvseriesRecommendations,
      tvseriesRecommendationsState:
          tvseriesRecommendationsState ?? this.tvseriesRecommendationsState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  //tambahkan juga factory contructor untuk membuat initial state nya
  factory TvseriesDetailState.initial() => TvseriesDetailState(
        tvseriesDetail: null,
        tvseriesDetailState: RequestState.Empty,
        tvseriesRecommendations: [],
        tvseriesRecommendationsState: RequestState.Empty,
        message: '',
        watchlistMessage: '',
        isAddedToWatchlist: false,
      );

  @override
  List<Object?> get props => [
        tvseriesDetail,
        tvseriesDetailState,
        tvseriesRecommendations,
        tvseriesRecommendationsState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
