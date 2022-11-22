// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, annotate_overrides, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MoviesWatchlistCubit>().getMoviesWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MoviesWatchlistCubit>().getMoviesWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesWatchlistCubit, MoviesListState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.watchlistMovies;
                  return MovieCard(movie[index]);
                },
                itemCount: state.watchlistMovies.length,
              );
            } else if (state is MoviesError) {
              return Expanded(
                child: Text(state.message),
              );
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
