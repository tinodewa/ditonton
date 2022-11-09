// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:core/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TvseriesResponse extends Equatable {
  final List<TvSeriesModel> tvseriesList;

  TvseriesResponse({required this.tvseriesList});

  factory TvseriesResponse.fromJson(Map<String, dynamic> json) =>
      TvseriesResponse(
        tvseriesList: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvseriesList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvseriesList];
}
