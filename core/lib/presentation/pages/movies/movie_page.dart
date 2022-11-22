// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/cubit/movies/movies_cubit.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movies/movie_detail_page.dart';
import 'package:core/presentation/pages/movies/popular_movies_page.dart';
import 'package:core/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/widgets/tapable_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

////movie
class MovieHome extends StatefulWidget {
  const MovieHome({super.key});

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MoviesListCubit>().getMoviesList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MoviesListCubit, MoviesListState>(
                  builder: (context, state) {
                    if (state is MoviesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListHasData) {
                      return MovieList(state.nowPlayingMovies);
                    } else if (state is MoviesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                )
              ],
            ),
            TapableSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MoviesListCubit, MoviesListState>(
                  builder: (context, state) {
                    if (state is MoviesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListHasData) {
                      return MovieList(state.popularMovies);
                    } else if (state is MoviesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                )
              ],
            ),
            TapableSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MoviesListCubit, MoviesListState>(
                  builder: (context, state) {
                    if (state is MoviesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieListHasData) {
                      return MovieList(state.topRatedMovies);
                    } else if (state is MoviesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
