import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_tvseries.dart';
import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvseries])
@GenerateMocks([GetPopularTvseries])
@GenerateMocks([GetTopRatedTvseries])
@GenerateMocks([GetWatchlistTvseries])
void main() {
  late TvseriesListCubit tvseriesListCubit;
  late TvseriesPopularCubit tvseriesPopularCubit;
  late TvseriesTopRatedCubit tvseriesTopRatedCubit;
  late TvseriesWatchlistCubit tvseriesWatchlistCubit;
  late MockGetNowPlayingTvseries mockGetNowPlayingTvseries;
  late MockGetPopularTvseries mockGetPopularTvseries;
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late MockGetWatchlistTvseries mockGetWatchlistTvseries;

  setUp(() {
    mockGetNowPlayingTvseries = MockGetNowPlayingTvseries();
    mockGetPopularTvseries = MockGetPopularTvseries();
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    mockGetWatchlistTvseries = MockGetWatchlistTvseries();

    tvseriesListCubit = TvseriesListCubit(
      getNowPlayingTvseries: mockGetNowPlayingTvseries,
      getPopularTvseries: mockGetPopularTvseries,
      getTopRatedTvseries: mockGetTopRatedTvseries,
    );
    tvseriesPopularCubit = TvseriesPopularCubit(
      getPopularTvseries: mockGetPopularTvseries,
    );
    tvseriesTopRatedCubit = TvseriesTopRatedCubit(
      getTopRatedTvseries: mockGetTopRatedTvseries,
    );
    tvseriesWatchlistCubit = TvseriesWatchlistCubit(
      getWatchlistTvseries: mockGetWatchlistTvseries,
    );
  });

  group('Get Tv Series List Cubit', () {
    blocTest<TvseriesListCubit, TvseriesListState>(
      'Should return list of NowPlaying, Popular, and TopRated movies',
      build: () {
        when(mockGetNowPlayingTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));
        when(mockGetPopularTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));
        when(mockGetTopRatedTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesListCubit;
      },
      act: (bloc) => bloc.getTvseriesList(),
      expect: () => [
        TvseriesLoading(),
        TvseriesListHasData(
          testTvseriesList,
          testTvseriesList,
          testTvseriesList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvseries.execute());
        verify(mockGetPopularTvseries.execute());
        verify(mockGetTopRatedTvseries.execute());
      },
    );

    blocTest<TvseriesPopularCubit, TvseriesListState>(
      'Should return list of Popular tv series',
      build: () {
        when(mockGetPopularTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesPopularCubit;
      },
      act: (bloc) => bloc.getTvseriesPopular(),
      expect: () => [
        TvseriesLoading(),
        TvseriesPopularHasData(testTvseriesList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvseries.execute());
      },
    );

    blocTest<TvseriesTopRatedCubit, TvseriesListState>(
      'Should return list of Top Rated tv series',
      build: () {
        when(mockGetTopRatedTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesTopRatedCubit;
      },
      act: (bloc) => bloc.getTvseriesTopRated(),
      expect: () => [
        TvseriesLoading(),
        TvseriesTopRatedHasData(testTvseriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvseries.execute());
      },
    );

    blocTest<TvseriesWatchlistCubit, TvseriesListState>(
      'Should return list of Top watchlist movies',
      build: () {
        when(mockGetWatchlistTvseries.execute())
            .thenAnswer((_) async => Right(testTvseriesList));

        return tvseriesWatchlistCubit;
      },
      act: (bloc) => bloc.getTvseriesWatchlist(),
      expect: () => [
        TvseriesLoading(),
        TvseriesWatchlistHasData(testTvseriesList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvseries.execute());
      },
    );
  });
}
