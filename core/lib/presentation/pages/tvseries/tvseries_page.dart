// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/presentation/cubit/tvseries/tvseries_cubit.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/presentation/pages/tvseries/popular_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/top_rated_tvseries_page.dart';
import 'package:core/presentation/pages/tvseries/tvseries_detail_page.dart';
import 'package:core/presentation/widgets/tapable_sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

////tv series
class TvSeriesHome extends StatefulWidget {
  const TvSeriesHome({super.key});

  @override
  State<TvSeriesHome> createState() => _TvSeriesHomeState();
}

class _TvSeriesHomeState extends State<TvSeriesHome> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvseriesListCubit>().getTvseriesList());
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
                BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                    if (state is TvseriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvseriesListHasData) {
                      return TvseriesList(state.nowPlayingTvseries);
                    } else if (state is TvseriesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ],
            ),
            TapableSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvseriesPage.ROUTE_NAME),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                    if (state is TvseriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvseriesListHasData) {
                      return TvseriesList(state.popularTvseries);
                    } else if (state is TvseriesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ],
            ),
            TapableSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvseriesPage.ROUTE_NAME),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<TvseriesListCubit, TvseriesListState>(
                  builder: (context, state) {
                    if (state is TvseriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TvseriesListHasData) {
                      return TvseriesList(state.topRatedTvseries);
                    } else if (state is TvseriesError) {
                      return Expanded(
                        child: Text(state.message),
                      );
                    } else {
                      return Text('Failed');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TvseriesList extends StatelessWidget {
  final List<TvSeries> tvseries;

  TvseriesList(this.tvseries, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvseries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvseriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvseries.length,
      ),
    );
  }
}
