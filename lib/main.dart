import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/search_bloc.dart';
import 'package:search/presentation/pages/movies/search_movie_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:core/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:search/presentation/pages/tvseries/search_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:core/presentation/pages/tvseries/watchlist_tvseries_page.dart';
import 'package:core/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:core/presentation/provider/movies/movie_list_notifier.dart';
import 'package:search/presentation/provider/movies/movie_search_notifier.dart';
import 'package:core/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:core/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/tvseries/tvseries_detail_notifier.dart';
import 'package:core/presentation/provider/tvseries/tvseries_list_notifier.dart';
import 'package:search/presentation/provider/tvseries/tvseries_search_notifier.dart';
import 'package:core/presentation/provider/tvseries/popular_tvseries_notifier.dart';
import 'package:core/presentation/provider/tvseries/top_rated_tvseries_notifier.dart';
import 'package:core/presentation/provider/tvseries/watchlist_tvseries_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ////movies
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        //// tvseries
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvseriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvseriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvseriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvseriesNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvseriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            //// movies
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            //// tv series
            case PopularTvseriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvseriesPage());
            case TopRatedTvseriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvseriesPage());
            case TvseriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvseriesDetailPage(id: id),
                settings: settings,
              );
            case SearchTvseriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvseriesPage());
            case WatchlistTvseriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvseriesPage());
            //// other
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
