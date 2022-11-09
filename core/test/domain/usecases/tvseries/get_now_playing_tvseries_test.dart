import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetNowPlayingTvseries(mockTvseriesRepository);
  });

  final tTvseries = <TvSeries>[];

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvseriesRepository.getNowPlayingTvseries())
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvseries));
  });
}
