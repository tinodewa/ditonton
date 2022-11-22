import 'package:core/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('testing tvseries detail event bloc', () {
    test('test tvseriesDetailEvent', () {
      expect(TvseriesDetailEvent, TvseriesDetailEvent);
    });

    test('should return Tvseries id when get Tvseries detail', () {
      final id = OnGetTvseriesDetail(1);

      expect(id, OnGetTvseriesDetail(1));
    });

    test('should return Tvseries id when get watchlist status', () {
      final id = GetWatchlistStatus(1);

      expect(id, GetWatchlistStatus(1));
    });

    test('should return Tvseries detail when add Tvseries to watchlist', () {
      final id = AddTvseriesWatchlist(testTvseriesDetail);

      expect(id, AddTvseriesWatchlist(testTvseriesDetail));
    });

    test('should return Tvseries detail when remove Tvseries to watchlist', () {
      final id = RemoveTvseriesWatchlist(testTvseriesDetail);

      expect(id, RemoveTvseriesWatchlist(testTvseriesDetail));
    });
  });
}
