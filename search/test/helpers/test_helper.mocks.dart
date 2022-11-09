// Mocks generated by Mockito 5.3.2 from annotations
// in search/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i24;
import 'dart:typed_data' as _i25;

import 'package:core/core.dart' as _i8;
import 'package:core/data/datasources/db/database_helper.dart' as _i22;
import 'package:core/data/datasources/movie_local_data_source.dart' as _i13;
import 'package:core/data/datasources/movie_remote_data_source.dart' as _i11;
import 'package:core/data/datasources/tvseries_local_data_source.dart' as _i20;
import 'package:core/data/datasources/tvseries_remote_data_source.dart' as _i18;
import 'package:core/data/models/movie_detail_model.dart' as _i3;
import 'package:core/data/models/movie_model.dart' as _i12;
import 'package:core/data/models/movie_table.dart' as _i14;
import 'package:core/data/models/tvseries_detail_model.dart' as _i4;
import 'package:core/data/models/tvseries_model.dart' as _i19;
import 'package:core/data/models/tvseries_table.dart' as _i21;
import 'package:core/domain/entities/movie.dart' as _i9;
import 'package:core/domain/entities/movie_detail.dart' as _i10;
import 'package:core/domain/entities/tvseries.dart' as _i16;
import 'package:core/domain/entities/tvseries_detail.dart' as _i17;
import 'package:core/domain/repositories/movie_repository.dart' as _i6;
import 'package:core/domain/repositories/tvseries_repository.dart' as _i15;
import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite_sqlcipher/sqflite.dart' as _i23;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailResponse_1 extends _i1.SmartFake
    implements _i3.MovieDetailResponse {
  _FakeMovieDetailResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvseriesDetailResponse_2 extends _i1.SmartFake
    implements _i4.TvseriesDetailResponse {
  _FakeTvseriesDetailResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #getNowPlayingMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getPopularMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #getPopularMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getTopRatedMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #getTopRatedMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>> getMovieDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>.value(
                _FakeEither_0<_i8.Failure, _i10.MovieDetail>(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i10.MovieDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getMovieRecommendations(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #getMovieRecommendations,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> searchMovies(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #searchMovies,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlistMovies(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistMovies,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistMovies,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlistMovies(
          _i10.MovieDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovies,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistMovies,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlistMovies(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlistMovies,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>.value(
            _FakeEither_0<_i8.Failure, List<_i9.Movie>>(
          this,
          Invocation.method(
            #getWatchlistMovies,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i9.Movie>>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i12.MovieModel>> getNowPlayingMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]),
      ) as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getPopularMovies() => (super.noSuchMethod(
        Invocation.method(
          #getPopularMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]),
      ) as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> getTopRatedMovies() => (super.noSuchMethod(
        Invocation.method(
          #getTopRatedMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]),
      ) as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<_i3.MovieDetailResponse> getMovieDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieDetail,
          [id],
        ),
        returnValue: _i7.Future<_i3.MovieDetailResponse>.value(
            _FakeMovieDetailResponse_1(
          this,
          Invocation.method(
            #getMovieDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i3.MovieDetailResponse>);
  @override
  _i7.Future<List<_i12.MovieModel>> getMovieRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieRecommendations,
          [id],
        ),
        returnValue:
            _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]),
      ) as _i7.Future<List<_i12.MovieModel>>);
  @override
  _i7.Future<List<_i12.MovieModel>> searchMovies(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchMovies,
          [query],
        ),
        returnValue:
            _i7.Future<List<_i12.MovieModel>>.value(<_i12.MovieModel>[]),
      ) as _i7.Future<List<_i12.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i13.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistMovies(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistMovies,
          [movie],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistMovies(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovies,
          [movie],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i14.MovieTable?> getMovieById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i7.Future<_i14.MovieTable?>.value(),
      ) as _i7.Future<_i14.MovieTable?>);
  @override
  _i7.Future<List<_i14.MovieTable>> getWatchlistMovies() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue:
            _i7.Future<List<_i14.MovieTable>>.value(<_i14.MovieTable>[]),
      ) as _i7.Future<List<_i14.MovieTable>>);
}

/// A class which mocks [TvseriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesRepository extends _i1.Mock
    implements _i15.TvseriesRepository {
  MockTvseriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>
      getNowPlayingTvseries() => (super.noSuchMethod(
            Invocation.method(
              #getNowPlayingTvseries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
              this,
              Invocation.method(
                #getNowPlayingTvseries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>
      getPopularTvseries() => (super.noSuchMethod(
            Invocation.method(
              #getPopularTvseries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
              this,
              Invocation.method(
                #getPopularTvseries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>
      getTopRatedTvseries() => (super.noSuchMethod(
            Invocation.method(
              #getTopRatedTvseries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
              this,
              Invocation.method(
                #getTopRatedTvseries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, _i17.TvseriesDetail>> getTvseriesDetail(
          int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesDetail,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, _i17.TvseriesDetail>>.value(
                _FakeEither_0<_i8.Failure, _i17.TvseriesDetail>(
          this,
          Invocation.method(
            #getTvseriesDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i17.TvseriesDetail>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>
      getTvseriesRecommendations(int? id) => (super.noSuchMethod(
            Invocation.method(
              #getTvseriesRecommendations,
              [id],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
              this,
              Invocation.method(
                #getTvseriesRecommendations,
                [id],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>> searchTvseries(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvseries,
          [query],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
          this,
          Invocation.method(
            #searchTvseries,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> saveWatchlistTvseries(
          _i17.TvseriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveWatchlistTvseries,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #saveWatchlistTvseries,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, String>> removeWatchlistTvseries(
          _i17.TvseriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTvseries,
          [movie],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, String>>.value(
            _FakeEither_0<_i8.Failure, String>(
          this,
          Invocation.method(
            #removeWatchlistTvseries,
            [movie],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, String>>);
  @override
  _i7.Future<bool> isAddedToWatchlistTvseries(int? id) => (super.noSuchMethod(
        Invocation.method(
          #isAddedToWatchlistTvseries,
          [id],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>
      getWatchlistTvseries() => (super.noSuchMethod(
            Invocation.method(
              #getWatchlistTvseries,
              [],
            ),
            returnValue:
                _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>.value(
                    _FakeEither_0<_i8.Failure, List<_i16.TvSeries>>(
              this,
              Invocation.method(
                #getWatchlistTvseries,
                [],
              ),
            )),
          ) as _i7.Future<_i2.Either<_i8.Failure, List<_i16.TvSeries>>>);
}

/// A class which mocks [TvseriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesRemoteDataSource extends _i1.Mock
    implements _i18.TvseriesRemoteDataSource {
  MockTvseriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<List<_i19.TvSeriesModel>> getNowPlayingTvseries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getNowPlayingTvseries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i19.TvSeriesModel>>.value(<_i19.TvSeriesModel>[]),
      ) as _i7.Future<List<_i19.TvSeriesModel>>);
  @override
  _i7.Future<List<_i19.TvSeriesModel>> getPopularTvseries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPopularTvseries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i19.TvSeriesModel>>.value(<_i19.TvSeriesModel>[]),
      ) as _i7.Future<List<_i19.TvSeriesModel>>);
  @override
  _i7.Future<List<_i19.TvSeriesModel>> getTopRatedTvseries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopRatedTvseries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i19.TvSeriesModel>>.value(<_i19.TvSeriesModel>[]),
      ) as _i7.Future<List<_i19.TvSeriesModel>>);
  @override
  _i7.Future<_i4.TvseriesDetailResponse> getTvseriesDetail(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesDetail,
          [id],
        ),
        returnValue: _i7.Future<_i4.TvseriesDetailResponse>.value(
            _FakeTvseriesDetailResponse_2(
          this,
          Invocation.method(
            #getTvseriesDetail,
            [id],
          ),
        )),
      ) as _i7.Future<_i4.TvseriesDetailResponse>);
  @override
  _i7.Future<List<_i19.TvSeriesModel>> getTvseriesRecommendations(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesRecommendations,
          [id],
        ),
        returnValue:
            _i7.Future<List<_i19.TvSeriesModel>>.value(<_i19.TvSeriesModel>[]),
      ) as _i7.Future<List<_i19.TvSeriesModel>>);
  @override
  _i7.Future<List<_i19.TvSeriesModel>> searchTvseries(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchTvseries,
          [query],
        ),
        returnValue:
            _i7.Future<List<_i19.TvSeriesModel>>.value(<_i19.TvSeriesModel>[]),
      ) as _i7.Future<List<_i19.TvSeriesModel>>);
}

/// A class which mocks [TvseriesLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvseriesLocalDataSource extends _i1.Mock
    implements _i20.TvseriesLocalDataSource {
  MockTvseriesLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<String> insertWatchlistTvseries(_i21.TvseriesTable? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistTvseries,
          [tvseries],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<String> removeWatchlistTvseries(_i21.TvseriesTable? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTvseries,
          [tvseries],
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i21.TvseriesTable?> getTvseriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesById,
          [id],
        ),
        returnValue: _i7.Future<_i21.TvseriesTable?>.value(),
      ) as _i7.Future<_i21.TvseriesTable?>);
  @override
  _i7.Future<List<_i21.TvseriesTable>> getWatchlistTvseries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvseries,
          [],
        ),
        returnValue:
            _i7.Future<List<_i21.TvseriesTable>>.value(<_i21.TvseriesTable>[]),
      ) as _i7.Future<List<_i21.TvseriesTable>>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i22.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i23.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i7.Future<_i23.Database?>.value(),
      ) as _i7.Future<_i23.Database?>);
  @override
  _i7.Future<int> insertWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistMovie(_i14.MovieTable? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistMovie,
          [movie],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getMovieById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistMovies() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistMovies,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
  @override
  _i7.Future<int> insertWatchlisTvseries(_i21.TvseriesTable? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWatchlisTvseries,
          [tvseries],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<int> removeWatchlistTvseries(_i21.TvseriesTable? tvseries) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeWatchlistTvseries,
          [tvseries],
        ),
        returnValue: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<Map<String, dynamic>?> getTvseriesById(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTvseriesById,
          [id],
        ),
        returnValue: _i7.Future<Map<String, dynamic>?>.value(),
      ) as _i7.Future<Map<String, dynamic>?>);
  @override
  _i7.Future<List<Map<String, dynamic>>> getWatchlistTvseries() =>
      (super.noSuchMethod(
        Invocation.method(
          #getWatchlistTvseries,
          [],
        ),
        returnValue: _i7.Future<List<Map<String, dynamic>>>.value(
            <Map<String, dynamic>>[]),
      ) as _i7.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i24.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i24.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i24.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i24.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);
  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(''),
      ) as _i7.Future<String>);
  @override
  _i7.Future<_i25.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i25.Uint8List>.value(_i25.Uint8List(0)),
      ) as _i7.Future<_i25.Uint8List>);
  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i5.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
