// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_status_tvseries.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
  final GetTvseriesDetail _getTvseriesDetail;
  final GetTvseriesRecommendations _getTvseriesRecommendations;
  final GetWatchListStatusTvseries _getWatchListStatusTvseries;
  final SaveWatchlistTvseries _saveWatchlisTvseries;
  final RemoveWatchlistTvseries _removeWatchlistTvseries;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvseriesDetailBloc(
      this._getTvseriesDetail,
      this._getTvseriesRecommendations,
      this._getWatchListStatusTvseries,
      this._saveWatchlisTvseries,
      this._removeWatchlistTvseries)
      : super(TvseriesDetailState.initial()) {
    on<OnGetTvseriesDetail>((event, emit) async {
      emit(state.copyWith(tvseriesDetailState: RequestState.Loading));

      final resultDetail = await _getTvseriesDetail.execute(event.id);
      final resultRecommendation =
          await _getTvseriesRecommendations.execute(event.id);

      resultDetail.fold(
        (failure) async {
          emit(
            state.copyWith(
              tvseriesDetailState: RequestState.Error,
              message: failure.message,
            ),
          );
        },
        (tvseriesDetail) async {
          emit(
            state.copyWith(
              tvseriesRecommendationsState: RequestState.Loading,
              tvseriesDetail: tvseriesDetail,
              tvseriesDetailState: RequestState.Loaded,
              message: '',
            ),
          );
          resultRecommendation.fold(
            (failure) {
              emit(
                state.copyWith(
                  tvseriesRecommendationsState: RequestState.Error,
                  message: failure.message,
                ),
              );
            },
            (tvseriesRecommendation) {
              emit(
                state.copyWith(
                  tvseriesRecommendationsState: RequestState.Loaded,
                  tvseriesRecommendations: tvseriesRecommendation,
                  message: '',
                ),
              );
            },
          );
        },
      );
    });
    on<GetWatchlistStatus>((event, emit) async {
      final result = await _getWatchListStatusTvseries.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
    on<AddTvseriesWatchlist>((event, emit) async {
      final result = await _saveWatchlisTvseries.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(GetWatchlistStatus(event.tvseriesDetail.id));
    });
    on<RemoveTvseriesWatchlist>((event, emit) async {
      final result =
          await _removeWatchlistTvseries.execute(event.tvseriesDetail);

      result.fold((failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      }, (successMessage) {
        emit(state.copyWith(watchlistMessage: successMessage));
      });

      add(GetWatchlistStatus(event.tvseriesDetail.id));
    });
  }
}
