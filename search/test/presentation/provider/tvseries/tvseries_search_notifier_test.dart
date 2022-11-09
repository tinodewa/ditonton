// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:search/domain/usecases/tvseries/search_tvseries.dart';
import 'package:search/presentation/provider/tvseries/tvseries_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvseries])
void main() {
  late TvseriesSearchNotifier provider;
  late MockSearchTvseries mockSearchTvseries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvseries = MockSearchTvseries();
    provider = TvseriesSearchNotifier(searchTvseries: mockSearchTvseries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvseriesModel = TvSeries(
    backdropPath: "/gpJZiTvklr5JN0mzpQwl99peQD7.jpg",
    firstAirDate: DateTime.parse("1966-01-12"),
    genreIds: [10765, 35, 10759],
    id: 2287,
    name: "Batman",
    originCountry: ["US"],
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
  final tQuery = 'batman';

  group('search tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvseriesList));
      // act
      await provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTvseriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvseries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvseriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
