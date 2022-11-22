import 'package:core/presentation/bloc/movies/movies_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_objects.dart';

void main() {
  group('testing movies detail event bloc', () {
    test('test moviesDetailEvent', () {
      expect(MoviesDetailEvent, MoviesDetailEvent);
    });

    test('should return movies id when get movies detail', () {
      final id = OnGetMoviesDetail(1);

      expect(id, OnGetMoviesDetail(1));
    });

    test('should return movies id when get watchlist status', () {
      final id = GetWatchlistStatus(1);

      expect(id, GetWatchlistStatus(1));
    });

    test('should return movies detail when add movies to watchlist', () {
      final id = AddMoviesWatchlist(testMovieDetail);

      expect(id, AddMoviesWatchlist(testMovieDetail));
    });

    test('should return movies detail when remove movies to watchlist', () {
      final id = RemoveMoviesWatchlist(testMovieDetail);

      expect(id, RemoveMoviesWatchlist(testMovieDetail));
    });
  });
}
