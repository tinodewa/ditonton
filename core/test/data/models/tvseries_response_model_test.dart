// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:core/data/models/tvseries_model.dart';
import 'package:core/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvseriesModel = TvSeriesModel(
    backdropPath: "/saeIuFYm6faEH6aonT2Ag5zszFC.jpg",
    firstAirDate: DateTime.parse("2021-10-12"),
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2561.86,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3376,
  );
  final tTvseriesResponseModel =
      TvseriesResponse(tvseriesList: <TvSeriesModel>[tTvseriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_response.json'));
      // act
      final result = TvseriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvseriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvseriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/saeIuFYm6faEH6aonT2Ag5zszFC.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [80, 10765],
            "id": 90462,
            "name": "Chucky",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Chucky",
            "overview":
                "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
            "popularity": 2561.86,
            "poster_path": "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
            "vote_average": 7.9,
            "vote_count": 3376
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
