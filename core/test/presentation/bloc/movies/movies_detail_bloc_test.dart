// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:core/presentation/bloc/movies/movies_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movies_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
@GenerateMocks([GetMovieRecommendations])
@GenerateMocks([GetWatchListStatusMovie])
@GenerateMocks([SaveWatchlistMovies])
@GenerateMocks([RemoveWatchlistMovie])
void main() {
  late MoviesDetailBloc moviesDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovies mockSaveWatchlistMovies;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovies = MockSaveWatchlistMovies();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();

    moviesDetailBloc = MoviesDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListStatusMovie,
      mockSaveWatchlistMovies,
      mockRemoveWatchlistMovie,
    );
  });

  group('Get Movie Detail', () {
    test('initial movies detail state should be empty', () {
      expect(moviesDetailBloc.state.movieDetailState, RequestState.Empty);
    });

    test('initial movies recommendations state should be empty', () {
      expect(
          moviesDetailBloc.state.movieRecommendationsState, RequestState.Empty);
    });

    blocTest<MoviesDetailBloc, MovieDetailState>(
      'Should emit movieDetailStateLoading, recommendationStateLoading, MovieDetailLoaded, and recommendationLoaded when movies detail and recommendation data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));

        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetMoviesDetail(1)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          message: '',
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loaded,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          movieRecommendations: testMovieList,
          message: '',
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MoviesDetailBloc, MovieDetailState>(
      'Should emit movieDetailStateLoading, MovieDetailError when movies detail data is gotten unsuccesfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Right(testMovieList));

        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetMoviesDetail(1)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MoviesDetailBloc, MovieDetailState>(
      'Should emit movieDetailStateLoading, recommendationStateLoading, MovieDetailLoaded, and recommendationError when movies detail success but recommendation data is unsuccesfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return moviesDetailBloc;
      },
      act: (bloc) => bloc.add(OnGetMoviesDetail(1)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.Loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Loading,
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          message: '',
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.Error,
          movieDetailState: RequestState.Loaded,
          movieDetail: testMovieDetail,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
      },
    );

    blocTest<MoviesDetailBloc, MovieDetailState>(
      'Should emit watchlist status true when load movies watchlist status',
      build: () {
        when(mockSaveWatchlistMovies.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatusMovie.execute(1))
            .thenAnswer((_) async => true);

        return moviesDetailBloc;
      },
      act: (bloc) => [
        bloc.add(GetWatchlistStatus(1)),
        bloc.add(AddMoviesWatchlist(testMovieDetail))
      ],
      expect: () => [
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: true,
        ),
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovie.execute(1));
        verify(mockSaveWatchlistMovies.execute(testMovieDetail));
      },
    );

    blocTest<MoviesDetailBloc, MovieDetailState>(
      'Should emit watchlist status false when load movies watchlist status',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed to Watchlist'));
        when(mockGetWatchListStatusMovie.execute(1))
            .thenAnswer((_) async => false);

        return moviesDetailBloc;
      },
      act: (bloc) => [
        bloc.add(GetWatchlistStatus(1)),
        bloc.add(RemoveMoviesWatchlist(testMovieDetail))
      ],
      expect: () => [
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: false,
        ),
        MovieDetailState.initial().copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: 'Removed to Watchlist',
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovie.execute(1));
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });
}
