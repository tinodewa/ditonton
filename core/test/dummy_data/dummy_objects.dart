// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tvseries_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvseries = TvSeries(
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

final testTvseriesList = [testTvseries];

final testTvseriesDetail = TvseriesDetail(
  adult: false,
  backdropPath: "/84XPpjGvxNyExjSuLQe0SzioErt.jpg",
  createdBy: [
    CreatedByEntity(
      id: 66633,
      creditId: "52542286760ee31328001a7b",
      name: "Vince Gilligan",
      gender: 2,
      profilePath: "/uFh3OrBvkwKSU3N5y0XnXOhqBJz.jpg",
    ),
  ],
  episodeRunTime: [45, 47],
  firstAirDate: DateTime.parse("2008-01-20"),
  genres: [Genre(id: 18, name: "Drama")],
  homepage: "http://www.amc.com/shows/breaking-bad",
  id: 1396,
  inProduction: false,
  languages: ["en"],
  lastAirDate: DateTime.parse("2013-09-29"),
  lastEpisodeToAir: LastEpisodeToAirEntity(
    airDate: DateTime.parse("2013-09-29"),
    episodeNumber: 16,
    id: 62161,
    name: "felina",
    overview: "All bad things must come to an end.",
    productionCode: "",
    runtime: 55,
    seasonNumber: 5,
    showId: 1396,
    stillPath: "/pA0YwyhvdDXP3BEGL2grrIhq8aM.jpg",
    voteAverage: 9.293,
    voteCount: 147,
  ),
  name: "Breaking Bad",
  nextEpisodeToAir: LastEpisodeToAirEntity(
    airDate: DateTime.parse("2013-09-29"),
    episodeNumber: 16,
    id: 62161,
    name: "felina",
    overview: "All bad things must come to an end.",
    productionCode: "",
    runtime: 55,
    seasonNumber: 5,
    showId: 1396,
    stillPath: "/pA0YwyhvdDXP3BEGL2grrIhq8aM.jpg",
    voteAverage: 9.293,
    voteCount: 147,
  ),
  networks: [
    NetworkEntity(
        id: 174,
        name: "AMC",
        logoPath: "/pmvRmATOCaDykE6JrVoeYxlFHw3.png",
        originCountry: "US"),
  ],
  numberOfEpisodes: 62,
  numberOfSeasons: 5,
  originCountry: ["US"],
  originalLanguage: "en",
  originalName: "Breaking Bad",
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  popularity: 524.946,
  posterPath: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg",
  productionCompanies: [
    NetworkEntity(
        id: 11073,
        name: "Sony Pictures Television Studios",
        logoPath: "/aCbASRcI1MI7DXjPbSW9Fcv9uGR.png",
        originCountry: "US"),
  ],
  productionCountries: [
    ProductionCountryEntity(iso31661: "US", name: "United States of America"),
  ],
  seasons: [
    SeasonEntity(
        airDate: DateTime.parse("2008-01-20"),
        episodeCount: 7,
        id: 3572,
        name: "Season 1",
        overview:
            "High school chemistry teacher Walter White's life is suddenly transformed by a dire medical diagnosis. Street-savvy former student Jesse Pinkman \"teaches\" Walter a new trade.",
        posterPath: "/1BP4xYv9ZG4ZVHkL7ocOziBbSYH.jpg",
        seasonNumber: 1),
  ],
  spokenLanguages: [
    SpokenLanguageEntity(englishName: "English", iso6391: "en", name: "English")
  ],
  status: "Ended",
  tagline: "Remember my name",
  type: "Scripted",
  voteAverage: 8.84,
  voteCount: 10204,
);

final testWatchlistTvseries = TvSeries.watchList(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvseriesTable = TvSeries.watchList(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
);

final testTvseriesTable = TvseriesTable(
  id: 1396,
  name: 'Breaking Bad',
  posterPath: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  overview:
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
);

final testTvseriesMap = {
  'id': 1396,
  'name': 'Breaking Bad',
  'posterPath': '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
  'overview':
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
};
