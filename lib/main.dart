import 'package:core/presentation/bloc/movies/movies_detail_bloc.dart';
import 'package:core/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:core/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:core/presentation/pages/tvseries/watchlist_tvseries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ////movies
        BlocProvider(
          create: (_) => di.locator<MoviesListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesWatchlistCubit>(),
        ),
        //// tvseries
        BlocProvider(
          create: (_) => di.locator<TvseriesListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesWatchlistCubit>(),
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
