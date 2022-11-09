// ignore_for_file: prefer_const_declarations

import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:search/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = SearchTvseries(mockTvseriesRepository);
  });

  final tTvseries = <TvSeries>[];
  final tQuery = 'batman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvseriesRepository.searchTvseries(tQuery))
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvseries));
  });
}
