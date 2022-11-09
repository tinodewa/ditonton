// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:equatable/equatable.dart';

class TvseriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvseriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvseriesTable.fromEntity(TvseriesDetail tvseries) => TvseriesTable(
        id: tvseries.id,
        name: tvseries.name,
        posterPath: tvseries.posterPath,
        overview: tvseries.overview,
      );

  factory TvseriesTable.fromMap(Map<String, dynamic> map) => TvseriesTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
