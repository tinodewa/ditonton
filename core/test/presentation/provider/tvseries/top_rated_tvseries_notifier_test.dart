import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvseries])
void main() {
  late MockGetTopRatedTvseries mockGetTopRatedTvseries;
  late TopRatedTvseriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvseries = MockGetTopRatedTvseries();
    notifier =
        TopRatedTvseriesNotifier(getTopRatedTvseries: mockGetTopRatedTvseries)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => Right(testTvseriesList));
    // act
    notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => Right(testTvseriesList));
    // act
    await notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvseries, testTvseriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTvseries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvseries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
