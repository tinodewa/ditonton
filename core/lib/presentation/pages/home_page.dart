// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/pages/movies/movie_page.dart';
import 'package:search/presentation/pages/movies/search_movie_page.dart';
import 'package:core/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:search/presentation/pages/tvseries/search_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/watchlist_tvseries_page.dart';
import 'package:core/common/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget widgetForBody = MovieHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                setState(() {
                  widgetForBody = MovieHome();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV Series'),
              onTap: () {
                setState(() {
                  widgetForBody = TvSeriesHome();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movies'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvseriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("What are you looking for?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            SearchMoviePage.ROUTE_NAME,
                          );
                        },
                        child: Text(searchMovies),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                            context,
                            SearchTvseriesPage.ROUTE_NAME,
                          );
                        },
                        child: Text(searchTvseries),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: widgetForBody,
    );
  }
}
