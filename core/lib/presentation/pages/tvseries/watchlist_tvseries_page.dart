// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, annotate_overrides, prefer_const_constructors

import 'package:core/core.dart';
import 'package:core/presentation/provider/tvseries/watchlist_tvseries_notifier.dart';
import 'package:core/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<WatchlistTvseriesNotifier>(context, listen: false)
            .fetchWatchlistTvseries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistTvseriesNotifier>(context, listen: false)
        .fetchWatchlistTvseries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvseriesNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = data.watchlistTvseries[index];
                  return TvseriesCard(tvseries);
                },
                itemCount: data.watchlistTvseries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
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
