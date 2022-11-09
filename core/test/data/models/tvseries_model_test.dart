// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:core/data/models/tvseries_model.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvseriesModel = TvSeriesModel(
    backdropPath: '/7q448EVOnuE3gVAx24krzO7SNXM.jpg',
    firstAirDate: DateTime.parse("2021-09-03"),
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 38.342,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9,
    voteCount: 3101,
  );

  final tTvseries = TvSeries(
    backdropPath: '/7q448EVOnuE3gVAx24krzO7SNXM.jpg',
    firstAirDate: DateTime.parse("2021-09-03"),
    genreIds: [10764],
    id: 130392,
    name: "The D'Amelio Show",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "The D'Amelio Show",
    overview:
        "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
    popularity: 38.342,
    posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
    voteAverage: 9,
    voteCount: 3101,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvseriesModel.toEntity();
    expect(result, tTvseries);
  });
}
