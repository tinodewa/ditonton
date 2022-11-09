import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:search/bloc/search_event.dart';
import 'package:search/bloc/search_state.dart';
import 'package:search/domain/usecases/movies/search_movies.dart';
import 'package:search/domain/usecases/tvseries/search_tvseries.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
@GenerateMocks([SearchTvseries])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  late SearchTvseriesBloc searchTvseriesBloc;
  late MockSearchTvseries mockSearchTvseries;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);

    mockSearchTvseries = MockSearchTvseries();
    searchTvseriesBloc = SearchTvseriesBloc(mockSearchTvseries);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQueryMovies = 'spiderman';

  final tTvseriesModel = TvSeries(
    backdropPath: "/gpJZiTvklr5JN0mzpQwl99peQD7.jpg",
    firstAirDate: DateTime.parse("1966-01-12"),
    genreIds: const [10765, 35, 10759],
    id: 2287,
    name: "Batman",
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: "Batman",
    overview:
        "Wealthy entrepreneur Bruce Wayne and his ward Dick Grayson lead a double life: they are actually crime fighting duo Batman and Robin. A secret Batpole in the Wayne mansion leads to the Batcave, where Police Commissioner Gordon often calls with the latest emergency threatening Gotham City. Racing to the scene of the crime in the Batmobile, Batman and Robin must (with the help of their trusty Bat-utility-belt) thwart the efforts of a variety of master criminals, including The Riddler, The Joker, Catwoman, and The Penguin.",
    popularity: 74.087,
    posterPath: "/1ZEJuuDh0Zpi5ELM3Zev0GBhQ3R.jpg",
    voteAverage: 7.5,
    voteCount: 409,
  );

  final tTvseriesList = <TvSeries>[tTvseriesModel];
  const tQueryTvseries = 'batman';

  test('initial movies state should be empty', () {
    expect(searchMoviesBloc.state, SearchEmpty());
  });

  test('initial tvseries state should be empty', () {
    expect(searchTvseriesBloc.state, SearchEmpty());
  });

  blocTest<SearchMoviesBloc, SearchState>(
    'Should emit [Loading, HasData] when movies data is gotten succesfully',
    build: () {
      when(mockSearchMovies.execute(tQueryMovies))
          .thenAnswer((_) async => Right(tMovieList));

      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(onQueryChanged(tQueryMovies)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQueryMovies));
    },
  );

  blocTest<SearchTvseriesBloc, SearchState>(
    'Should emit [Loading, HasData] when tvseries data is gotten succesfully',
    build: () {
      when(mockSearchTvseries.execute(tQueryTvseries))
          .thenAnswer((_) async => Right(tTvseriesList));

      return searchTvseriesBloc;
    },
    act: (bloc) => bloc.add(onQueryChanged(tQueryTvseries)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchTvseriesHasData(tTvseriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvseries.execute(tQueryTvseries));
    },
  );

  blocTest<SearchMoviesBloc, SearchState>(
    'Should emit [Loading, Error] when movies get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQueryMovies))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(onQueryChanged(tQueryMovies)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQueryMovies));
    },
  );

  blocTest<SearchTvseriesBloc, SearchState>(
    'Should emit [Loading, Error] when tvseries get search is unsuccessful',
    build: () {
      when(mockSearchTvseries.execute(tQueryTvseries))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvseriesBloc;
    },
    act: (bloc) => bloc.add(onQueryChanged(tQueryTvseries)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvseries.execute(tQueryTvseries));
    },
  );
}
