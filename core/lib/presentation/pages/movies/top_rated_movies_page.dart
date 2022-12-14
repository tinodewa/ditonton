// ignore_for_file: library_private_types_in_public_api, constant_identifier_names, prefer_const_constructors

import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => context.read<MoviesTopRatedCubit>().getMoviesTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesTopRatedCubit, MoviesListState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.topRatedMovies;
                  return MovieCard(movie[index]);
                },
                itemCount: state.topRatedMovies.length,
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
        // Consumer<TopRatedMoviesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       return ListView.builder(
        //         itemBuilder: (context, index) {
        //           final movie = data.movies[index];
        //           return MovieCard(movie);
        //         },
        //         itemCount: data.movies.length,
        //       );
        //     } else {
        //       return Center(
        //         key: Key('error_message'),
        //         child: Text(data.message),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
