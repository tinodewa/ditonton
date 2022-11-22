// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvseriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  const TopRatedTvseriesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvseriesTopRatedCubit>().getTvseriesTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvseriesTopRatedCubit, TvseriesListState>(
          builder: (context, state) {
            if (state is TvseriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvseriesTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.topRatedTvseries;
                  return TvseriesCard(tvseries[index]);
                },
                itemCount: state.topRatedTvseries.length,
              );
            } else if (state is TvseriesError) {
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
