// part of 'search_movies_bloc.dart';

// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class onQueryChanged extends SearchEvent {
  final String query;

  onQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
