import 'package:core/core.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvseriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =
        TvseriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlisTvseries(testTvseriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result =
          await dataSource.insertWatchlistTvseries(testTvseriesTable);
      // assert
      expect(result, 'Added tv series to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlisTvseries(testTvseriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTvseries(testTvseriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvseries(testTvseriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result =
          await dataSource.removeWatchlistTvseries(testTvseriesTable);
      // assert
      expect(result, 'Removed tv series from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistTvseries(testTvseriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTvseries(testTvseriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tvseries Detail By Id', () {
    const tId = 1;

    test('should return Tvseries Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTvseriesById(tId))
          .thenAnswer((_) async => testTvseriesMap);
      // act
      final result = await dataSource.getTvseriesById(tId);
      // assert
      expect(result, testTvseriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTvseriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvseriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tvseries', () {
    test('should return list of TvseriesTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvseries())
          .thenAnswer((_) async => [testTvseriesMap]);
      // act
      final result = await dataSource.getWatchlistTvseries();
      // assert
      expect(result, [testTvseriesTable]);
    });
  });
}
