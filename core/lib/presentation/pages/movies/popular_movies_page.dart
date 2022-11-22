// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MoviesPopularCubit>().getMoviesPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviesPopularCubit, MoviesListState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviesPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.popularMovies;
                  return MovieCard(movie[index]);
                },
                itemCount: state.popularMovies.length,
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
}
