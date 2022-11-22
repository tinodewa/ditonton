// ignore_for_file: constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, prefer_is_empty, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tvseries/tvseries_detail_bloc.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvseriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  TvseriesDetailPage({super.key, required this.id});

  @override
  _TvseriesDetailPageState createState() => _TvseriesDetailPageState();
}

class _TvseriesDetailPageState extends State<TvseriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((() => context
        .read<TvseriesDetailBloc>()
        .add(OnGetTvseriesDetail(widget.id))));
    Future.microtask((() =>
        context.read<TvseriesDetailBloc>().add(GetWatchlistStatus(widget.id))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvseriesDetailBloc, TvseriesDetailState>(
        listener: (context, state) async {
          if (state.watchlistMessage ==
                  TvseriesDetailBloc.watchlistAddSuccessMessage ||
              state.watchlistMessage ==
                  TvseriesDetailBloc.watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.watchlistMessage),
              ),
            );
          } else {
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(state.watchlistMessage),
                );
              },
            );
          }
        },
        listenWhen: (previous, current) =>
            previous.watchlistMessage != current.watchlistMessage &&
            current.watchlistMessage != '',
        builder: (context, state) {
          if (state.tvseriesDetailState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvseriesDetailState == RequestState.Loaded) {
            final movie = state.tvseriesDetail!;
            return SafeArea(
              child: DetailContent(
                movie,
                state.tvseriesRecommendations,
                state.isAddedToWatchlist,
              ),
            );
          } else if (state.tvseriesDetailState == RequestState.Error) {
            return Center(
              child: Text(
                state.message,
                style: kSubtitle,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvseriesDetail tvseriesDetail;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(
      this.tvseriesDetail, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvseriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvseriesDetail.name,
                              style: kHeading5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (!isAddedWatchlist) {
                                      Provider.of<TvseriesDetailBloc>(
                                        context,
                                        listen: false,
                                      ).add(
                                          AddTvseriesWatchlist(tvseriesDetail));
                                    } else {
                                      Provider.of<TvseriesDetailBloc>(
                                        context,
                                        listen: false,
                                      ).add(RemoveTvseriesWatchlist(
                                          tvseriesDetail));
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedWatchlist
                                          ? Icon(Icons.check)
                                          : Icon(Icons.add),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _showGenres(tvseriesDetail.genres),
                            ),
                            Text(
                              _showDuration(
                                  tvseriesDetail.episodeRunTime.length > 0
                                      ? tvseriesDetail.episodeRunTime[0]
                                      : 0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvseriesDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvseriesDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvseriesDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            SizedBox(height: 16),
                            _showSeasons(tvseriesDetail.seasons),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvseriesDetailBloc,
                                TvseriesDetailState>(
                              builder: (context, state) {
                                if (state.tvseriesRecommendationsState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.tvseriesRecommendationsState ==
                                    RequestState.Error) {
                                  return Text(state.message);
                                } else if (state.tvseriesRecommendationsState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvseriesDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    if (runtime != null) {
      final int hours = runtime ~/ 60;
      final int minutes = runtime % 60;

      if (hours > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${minutes}m';
      }
    } else {
      return "Empty";
    }
  }

  Widget _showSeasons(List<SeasonEntity> season) {
    return Column(
      children: season
          .map(
            (season) => Row(
              children: [
                Container(
                  width: 70.0,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    season.seasonNumber.toString(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                ),
                Text('Total episode : '),
                Text(
                  season.episodeCount.toString(),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
//180999
