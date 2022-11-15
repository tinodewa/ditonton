import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvseriesRepository,
  TvseriesRemoteDataSource,
  TvseriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<HttpClient>(as: #MockHttp),
])
void main() {}
