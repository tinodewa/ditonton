import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
@GenerateMocks([GetPopularMovies])
@GenerateMocks([GetTopRatedMovies])
@GenerateMocks([GetWatchlistMovies])
void main() {
  late MoviesListCubit moviesListCubit;
  late MoviesPopularCubit moviesPopularCubit;
  late MoviesTopRatedCubit moviesTopRatedCubit;
  late MoviesWatchlistCubit moviesWatchlistCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();

    moviesListCubit = MoviesListCubit(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    moviesPopularCubit = MoviesPopularCubit(
      getPopularMovies: mockGetPopularMovies,
    );
    moviesTopRatedCubit = MoviesTopRatedCubit(
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    moviesWatchlistCubit = MoviesWatchlistCubit(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group('Get Movies List Cubit', () {
    blocTest<MoviesListCubit, MoviesListState>(
      'Should return list of NowPlaying, Popular, and TopRated movies',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return moviesListCubit;
      },
      act: (bloc) => bloc.getMoviesList(),
      expect: () => [
        MoviesLoading(),
        MovieListHasData(
          testMovieList,
          testMovieList,
          testMovieList,
        ),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        verify(mockGetPopularMovies.execute());
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MoviesPopularCubit, MoviesListState>(
      'Should return list of Popular movies',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return moviesPopularCubit;
      },
      act: (bloc) => bloc.getMoviesPopular(),
      expect: () => [
        MoviesLoading(),
        MoviesPopularHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviesTopRatedCubit, MoviesListState>(
      'Should return list of Top Rated movies',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return moviesTopRatedCubit;
      },
      act: (bloc) => bloc.getMoviesTopRated(),
      expect: () => [
        MoviesLoading(),
        MoviesTopRatedHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MoviesWatchlistCubit, MoviesListState>(
      'Should return list of Top watchlist movies',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return moviesWatchlistCubit;
      },
      act: (bloc) => bloc.getMoviesWatchlist(),
      expect: () => [
        MoviesLoading(),
        MoviesWatchlistHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
