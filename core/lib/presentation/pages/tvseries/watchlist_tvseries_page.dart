// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, annotate_overrides, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvseriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tvseries';

  @override
  _WatchlistTvseriesPageState createState() => _WatchlistTvseriesPageState();
}

class _WatchlistTvseriesPageState extends State<WatchlistTvseriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvseriesWatchlistCubit>().getTvseriesWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<TvseriesWatchlistCubit>().getTvseriesWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvseriesWatchlistCubit, TvseriesListState>(
          builder: (context, state) {
            if (state is TvseriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvseriesWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = state.watchlistTvseries;
                  return TvseriesCard(tvseries[index]);
                },
                itemCount: state.watchlistTvseries.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
