import 'package:core/domain/usecases/tvseries/get_warchlist_status_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTvseries usecase;
  late MockTvseriesRepository mockTvseriesRepository;

  setUp(() {
    mockTvseriesRepository = MockTvseriesRepository();
    usecase = GetWatchListStatusTvseries(mockTvseriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvseriesRepository.isAddedToWatchlistTvseries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
