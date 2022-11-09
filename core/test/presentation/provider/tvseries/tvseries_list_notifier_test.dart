import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvseries, GetPopularTvseries, GetTopRatedTvseries])
void main() {
  late TvseriesListNotifier provider;
  late MockGetNowPlayingTvseries mockGetNowPlayingTvseries;
  late MockGetPopularTvseries mockGetPopularTvseries;
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvseries = MockGetNowPlayingTvseries();
    mockGetPopularTvseries = MockGetPopularTvseries();
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    provider = TvseriesListNotifier(
      getNowPlayingTvseries: mockGetNowPlayingTvseries,
      getPopularTvseries: mockGetPopularTvseries,
      getTopRatedTvseries: mockGetTopRatedTvseries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      provider.fetchNowPlayingTvseries();
      // assert
      verify(mockGetNowPlayingTvseries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change Tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      await provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvseries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvseries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular Tvseries', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change Tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      await provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Loaded);
      expect(provider.popularTvseries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvseries();
      // assert
      expect(provider.popularTvseriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated Tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Loading);
    });

    test('should change Tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Right(testTvseriesList));
      // act
      await provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Loaded);
      expect(provider.topRatedTvseries, testTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvseries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvseries();
      // assert
      expect(provider.topRatedTvseriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
