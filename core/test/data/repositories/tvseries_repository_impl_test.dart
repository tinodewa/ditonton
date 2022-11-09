// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tvseries_detail_model.dart';
import 'package:core/data/models/tvseries_model.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvseriesRepositoryImpl repository;
  late MockTvseriesRemoteDataSource mockRemoteDataSource;
  late MockTvseriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvseriesRemoteDataSource();
    mockLocalDataSource = MockTvseriesLocalDataSource();
    repository = TvseriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvseriesModel = TvSeriesModel(
    backdropPath: "/saeIuFYm6faEH6aonT2Ag5zszFC.jpg",
    firstAirDate: DateTime.parse("2021-10-12"),
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2561.86,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3376,
  );

  final tTvseries = TvSeries(
    backdropPath: "/saeIuFYm6faEH6aonT2Ag5zszFC.jpg",
    firstAirDate: DateTime.parse("2021-10-12"),
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2561.86,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3376,
  );

  final tTvseriesModelList = <TvSeriesModel>[tTvseriesModel];
  final tTvseriesList = <TvSeries>[tTvseries];

  group('Now Playing Tv series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvseries())
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.getNowPlayingTvseries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvseries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvseries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvseries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvseries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvseries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvseries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvseries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv series', () {
    test('should return tv series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.getPopularTvseries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvseries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvseries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvseries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Series', () {
    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvseries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvseries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    const tId = 1396;
    final tTvseriesResponse = TvseriesDetailResponse(
      adult: false,
      backdropPath: "/84XPpjGvxNyExjSuLQe0SzioErt.jpg",
      createdBy: [
        CreatedBy(
          id: 66633,
          creditId: "52542286760ee31328001a7b",
          name: "Vince Gilligan",
          gender: 2,
          profilePath: "/uFh3OrBvkwKSU3N5y0XnXOhqBJz.jpg",
        ),
      ],
      episodeRunTime: [45, 47],
      firstAirDate: DateTime.parse("2008-01-20"),
      genres: [GenreModel(id: 18, name: "Drama")],
      homepage: "http://www.amc.com/shows/breaking-bad",
      id: 1396,
      inProduction: false,
      languages: ["en"],
      lastAirDate: DateTime.parse("2013-09-29"),
      lastEpisodeToAir: LastEpisodeToAir(
        airDate: DateTime.parse("2013-09-29"),
        episodeNumber: 16,
        id: 62161,
        name: "felina",
        overview: "All bad things must come to an end.",
        productionCode: "",
        runtime: 55,
        seasonNumber: 5,
        showId: 1396,
        stillPath: "/pA0YwyhvdDXP3BEGL2grrIhq8aM.jpg",
        voteAverage: 9.293,
        voteCount: 147,
      ),
      name: "Breaking Bad",
      nextEpisodeToAir: LastEpisodeToAir(
        airDate: DateTime.parse("2013-09-29"),
        episodeNumber: 16,
        id: 62161,
        name: "felina",
        overview: "All bad things must come to an end.",
        productionCode: "",
        runtime: 55,
        seasonNumber: 5,
        showId: 1396,
        stillPath: "/pA0YwyhvdDXP3BEGL2grrIhq8aM.jpg",
        voteAverage: 9.293,
        voteCount: 147,
      ),
      networks: [
        Network(
            id: 174,
            name: "AMC",
            logoPath: "/pmvRmATOCaDykE6JrVoeYxlFHw3.png",
            originCountry: "US"),
      ],
      numberOfEpisodes: 62,
      numberOfSeasons: 5,
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Breaking Bad",
      overview:
          "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
      popularity: 524.946,
      posterPath: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg",
      productionCompanies: [
        Network(
            id: 11073,
            name: "Sony Pictures Television Studios",
            logoPath: "/aCbASRcI1MI7DXjPbSW9Fcv9uGR.png",
            originCountry: "US"),
      ],
      productionCountries: [
        ProductionCountry(iso31661: "US", name: "United States of America"),
      ],
      seasons: [
        Season(
            airDate: DateTime.parse("2008-01-20"),
            episodeCount: 7,
            id: 3572,
            name: "Season 1",
            overview:
                "High school chemistry teacher Walter White's life is suddenly transformed by a dire medical diagnosis. Street-savvy former student Jesse Pinkman \"teaches\" Walter a new trade.",
            posterPath: "/1BP4xYv9ZG4ZVHkL7ocOziBbSYH.jpg",
            seasonNumber: 1),
      ],
      spokenLanguages: [
        SpokenLanguage(englishName: "English", iso6391: "en", name: "English")
      ],
      status: "Ended",
      tagline: "Remember my name",
      type: "Scripted",
      voteAverage: 8.84,
      voteCount: 10204,
    );

    test(
        'should return Tv Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenAnswer((_) async => tTvseriesResponse);
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(Right(testTvseriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvseriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvseriesList = <TvSeriesModel>[];
    const tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenAnswer((_) async => tTvseriesList);
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvseriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvseriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvseriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvseriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv series', () {
    const tQuery = 'batman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenAnswer((_) async => tTvseriesModelList);
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvseriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvseries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvseries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvseries(testTvseriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvseries(testTvseriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistTvseries(testTvseriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvseries(testTvseriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvseries(testTvseriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
          await repository.removeWatchlistTvseries(testTvseriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistTvseries(testTvseriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result =
          await repository.removeWatchlistTvseries(testTvseriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist tv series status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvseriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistTvseries(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of tv series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvseries())
          .thenAnswer((_) async => [testTvseriesTable]);
      // act
      final result = await repository.getWatchlistTvseries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvseriesTable]);
    });
  });
}
