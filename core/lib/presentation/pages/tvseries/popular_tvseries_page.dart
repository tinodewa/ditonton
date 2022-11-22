// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvseriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  const PopularTvseriesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularTvseriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvseriesPopularCubit>().getTvseriesPopular());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvseriesPopularCubit, TvseriesListState>(
          builder: (context, state) {
            if (state is TvseriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvseriesPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.popularTvseries;
                  return TvseriesCard(tvseries[index]);
                },
                itemCount: state.popularTvseries.length,
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
