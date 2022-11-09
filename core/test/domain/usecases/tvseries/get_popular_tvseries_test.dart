import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetPopularTvseries(mockTvseriesRepository);
  });

  final tTvseries = <TvSeries>[];

  group('GetPopularTvseries Tests', () {
    group('execute', () {
      test(
          'should get list of tvseries from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvseriesRepository.getPopularTvseries())
            .thenAnswer((_) async => Right(tTvseries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvseries));
      });
    });
  });
}
