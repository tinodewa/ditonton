// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_status_tvseries.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:core/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvseriesDetail,
  GetTvseriesRecommendations,
  GetWatchListStatusTvseries,
  SaveWatchlistTvseries,
  RemoveWatchlistTvseries,
])
void main() {
  late TvseriesDetailNotifier provider;
  late MockGetTvseriesDetail mockGetTvseriesDetail;
  late MockGetTvseriesRecommendations mockGetTvseriesRecommendations;
  late MockGetWatchListStatusTvseries mockGetWatchlistStatus;
  late MockSaveWatchlistTvseries mockSaveWatchlist;
  late MockRemoveWatchlistTvseries mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvseriesDetail = MockGetTvseriesDetail();
    mockGetTvseriesRecommendations = MockGetTvseriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTvseries();
    mockSaveWatchlist = MockSaveWatchlistTvseries();
    mockRemoveWatchlist = MockRemoveWatchlistTvseries();
    provider = TvseriesDetailNotifier(
      getTvseriesDetail: mockGetTvseriesDetail,
      getTvseriesRecommendations: mockGetTvseriesRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 130392;

  void _arrangeUsecase() {
    when(mockGetTvseriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvseriesDetail));
    when(mockGetTvseriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(testTvseriesList));
  }

  group('Get Tv series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      verify(mockGetTvseriesDetail.execute(tId));
      verify(mockGetTvseriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv serius when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.Loaded);
      expect(provider.tvseries, testTvseriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.Loaded);
      expect(provider.tvseriesRecommendations, testTvseriesList);
    });
  });

  group('Get Tv serius Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      verify(mockGetTvseriesRecommendations.execute(tId));
      expect(provider.tvseriesRecommendations, testTvseriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvseriesRecommendations, testTvseriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvseriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvseriesDetail));
      when(mockGetTvseriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvseriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvseriesDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvseriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvseriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvseriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvseriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvseriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvseriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvseriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      await provider.fetchTvseriesDetail(tId);
      // assert
      expect(provider.tvseriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
