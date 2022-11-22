import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_status_tvseries.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:core/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvseriesDetail])
@GenerateMocks([GetTvseriesRecommendations])
@GenerateMocks([GetWatchListStatusTvseries])
@GenerateMocks([SaveWatchlistTvseries])
@GenerateMocks([RemoveWatchlistTvseries])
void main() {
  late TvseriesDetailBloc tvseriesDetailBloc;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetTvseriesRecommendations mockGetTvseriesRecommendations;
  late MockGetWatchListStatusTvseries mockGetWatchListStatusTvseries;
  late MockSaveWatchlistTvseries mockSaveWatchlistTvseries;
  late MockRemoveWatchlistTvseries mockRemoveWatchlistTvseries;

  setUp(() {
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetTvseriesRecommendations = MockGetTvseriesRecommendations();
    mockGetWatchListStatusTvseries = MockGetWatchListStatusTvseries();
    mockSaveWatchlistTvseries = MockSaveWatchlistTvseries();
    mockRemoveWatchlistTvseries = MockRemoveWatchlistTvseries();

    tvseriesDetailBloc = TvseriesDetailBloc(
      mockGetTvseriesDetail,
      mockGetTvseriesRecommendations,
      mockGetWatchListStatusTvseries,
      mockSaveWatchlistTvseries,
      mockRemoveWatchlistTvseries,
    );
  });

  group('Get Tv Series Detail', () {
    test('initial tvseries detail state should be empty', () {
      expect(tvseriesDetailBloc.state.tvseriesDetailState, RequestState.Empty);
    });

    test('initial tvseries recommendations state should be empty', () {
      expect(tvseriesDetailBloc.state.tvseriesRecommendationsState,
          RequestState.Empty);
    });

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit tvseriesDetailStateLoading, recommendationStateLoading, tvseriesDetailLoaded, and recommendationLoaded when tvseries detail and recommendation data is gotten succesfully',
      build: () {
        when(mockGetTvseriesDetail.execute(1))
            .thenAnswer((_) async => Right(testTvseriesDetail));
        when(mockGetTvseriesRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetTvseriesDetail(1)),
      expect: () => [
        TvseriesDetailState.initial().copyWith(
          tvseriesDetailState: RequestState.Loading,
        ),
        TvseriesDetailState.initial().copyWith(
          tvseriesRecommendationsState: RequestState.Loading,
          tvseriesDetail: testTvseriesDetail,
          tvseriesDetailState: RequestState.Loaded,
          message: '',
        ),
        TvseriesDetailState.initial().copyWith(
          tvseriesRecommendationsState: RequestState.Loaded,
          tvseriesDetailState: RequestState.Loaded,
          tvseriesDetail: testTvseriesDetail,
          tvseriesRecommendations: testTvseriesList,
          message: '',
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvseriesDetail.execute(1));
        verify(mockGetTvseriesRecommendations.execute(1));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit TvseriesDetailStateLoading, TvseriesDetailError when Tvseriess detail data is gotten unsuccesfully',
      build: () {
        when(mockGetTvseriesDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvseriesRecommendations.execute(1))
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetTvseriesDetail(1)),
      expect: () => [
        TvseriesDetailState.initial().copyWith(
          tvseriesDetailState: RequestState.Loading,
        ),
        TvseriesDetailState.initial().copyWith(
          tvseriesDetailState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvseriesDetail.execute(1));
        verify(mockGetTvseriesRecommendations.execute(1));
      },
    );

    blocTest<TvseriesDetailBloc, TvseriesDetailState>(
      'Should emit TvseriesDetailStateLoading, recommendationStateLoading, TvseriesDetailLoaded, and recommendationError when Tvseriess detail success but recommendation data is unsuccesfully',
      build: () {
        when(mockGetTvseriesDetail.execute(1))
            .thenAnswer((_) async => Right(testTvseriesDetail));
        when(mockGetTvseriesRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return tvseriesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetTvseriesDetail(1)),
      expect: () => [
        TvseriesDetailState.initial().copyWith(
          tvseriesDetailState: RequestState.Loading,
        ),
        TvseriesDetailState.initial().copyWith(
          tvseriesRecommendationsState: RequestState.Loading,
          tvseriesDetail: testTvseriesDetail,
          tvseriesDetailState: RequestState.Loaded,
          message: '',
        ),
        TvseriesDetailState.initial().copyWith(
          tvseriesRecommendationsState: RequestState.Error,
          tvseriesDetailState: RequestState.Loaded,
          tvseriesDetail: testTvseriesDetail,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvseriesDetail.execute(1));
        verify(mockGetTvseriesRecommendations.execute(1));
      },
    );

    // blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    //   'Should emit watchlist status true when load Tvseries watchlist status',
    //   build: () {
    //     when(mockSaveWatchlistTvseries.execute(testTvseriesDetail))
    //         .thenAnswer((_) async => Right('Added to Watchlist'));
    //     when(mockGetWatchListStatusTvseries.execute(1))
    //         .thenAnswer((_) async => true);

    //     return tvseriesDetailBloc;
    //   },
    //   act: (bloc) => [
    //     bloc.add(GetWatchlistStatus(1)),
    //     bloc.add(AddTvseriesWatchlist(testTvseriesDetail))
    //   ],
    //   expect: () => [
    //     TvseriesDetailState.initial().copyWith(
    //       isAddedToWatchlist: true,
    //     ),
    //     TvseriesDetailState.initial().copyWith(
    //       isAddedToWatchlist: true,
    //       watchlistMessage: 'Added to Watchlist',
    //     ),
    //   ],
    //   verify: (bloc) {
    //     verify(mockGetWatchListStatusTvseries.execute(1));
    //     verify(mockSaveWatchlistTvseries.execute(testTvseriesDetail));
    //   },
    // );

    // blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    //   'Should emit watchlist status false when load Tvseries watchlist status',
    //   build: () {
    //     when(mockRemoveWatchlistTvseries.execute(testTvseriesDetail))
    //         .thenAnswer((_) async => Right('Removed to Watchlist'));
    //     when(mockGetWatchListStatusTvseries.execute(1))
    //         .thenAnswer((_) async => false);

    //     return tvseriesDetailBloc;
    //   },
    //   act: (bloc) => [
    //     bloc.add(GetWatchlistStatus(1)),
    //     bloc.add(RemoveTvseriesWatchlist(testTvseriesDetail))
    //   ],
    //   expect: () => [
    //     TvseriesDetailState.initial().copyWith(
    //       isAddedToWatchlist: false,
    //     ),
    //     TvseriesDetailState.initial().copyWith(
    //       isAddedToWatchlist: false,
    //       watchlistMessage: 'Removed to Watchlist',
    //     ),
    //   ],
    //   verify: (bloc) {
    //     verify(mockGetWatchListStatusTvseries.execute(1));
    //     verify(mockRemoveWatchlistTvseries.execute(testTvseriesDetail));
    //   },
    // );
  });
}
