// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SaveWatchlistTvseries(mockTvseriesRepository);
  });

  test('should save tvseries to the repository', () async {
    // arrange
    when(mockTvseriesRepository.saveWatchlistTvseries(testTvseriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvseriesDetail);
    // assert
    verify(mockTvseriesRepository.saveWatchlistTvseries(testTvseriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
