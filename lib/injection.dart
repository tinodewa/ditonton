import 'dart:io';

import 'package:core/presentation/bloc/movies/movies_detail_bloc.dart';
import 'package:core/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tvseries_local_data_source.dart';
import 'package:core/data/datasources/tvseries_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tvseries_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tvseries_repository.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:core/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:core/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:core/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:search/search.dart';
import 'package:core/domain/usecases/tvseries/get_now_playing_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_top_rated_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_detail.dart';
import 'package:core/domain/usecases/tvseries/get_tvseries_recommendations.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_status_tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/remove_watchlist_tvseries.dart';
import 'package:core/domain/usecases/tvseries/save_watchlist_tvseries.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:core/data/datasources/http_ssl_pinning.dart';

final locator = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SslPinning.ioClient;

  /// bloc
  // movies
  locator.registerLazySingleton(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MoviesListCubit(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MoviesPopularCubit(
      getPopularMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MoviesTopRatedCubit(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MoviesDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MoviesWatchlistCubit(
      getWatchlistMovies: locator(),
    ),
  );

  // tvseries
  locator.registerLazySingleton(
    () => SearchTvseriesBloc(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TvseriesListCubit(
      getNowPlayingTvseries: locator(),
      getPopularTvseries: locator(),
      getTopRatedTvseries: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TvseriesPopularCubit(
      getPopularTvseries: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TvseriesTopRatedCubit(
      getTopRatedTvseries: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TvseriesDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TvseriesWatchlistCubit(
      getWatchlistTvseries: locator(),
    ),
  );

  locator.registerLazySingleton<IOClient>(() => ioClient);

  /// use case
  // movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

// tvseries
  locator.registerLazySingleton(() => GetNowPlayingTvseries(locator()));
  locator.registerLazySingleton(() => GetPopularTvseries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvseries(locator()));
  locator.registerLazySingleton(() => GetTvseriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvseriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvseries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvseries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvseries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvseries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvseries(locator()));

  /// repository
  // movies
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // tvseries
  locator.registerLazySingleton<TvseriesRepository>(
    () => TvseriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  /// data sources
  // movies
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // tvseries
  locator.registerLazySingleton<TvseriesRemoteDataSource>(
      () => TvseriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvseriesLocalDataSource>(
      () => TvseriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpClient());
}
