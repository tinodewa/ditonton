// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = RemoveWatchlistTvseries(mockTvseriesRepository);
  });

  test('should remove watchlist tvseries from repository', () async {
    // arrange
    when(mockTvseriesRepository.removeWatchlistTvseries(testTvseriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvseriesDetail);
    // assert
    verify(mockTvseriesRepository.removeWatchlistTvseries(testTvseriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
