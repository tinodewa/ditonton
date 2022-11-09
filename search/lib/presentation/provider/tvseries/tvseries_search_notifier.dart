import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:search/domain/usecases/tvseries/search_tvseries.dart';
import 'package:flutter/foundation.dart';

class TvseriesSearchNotifier extends ChangeNotifier {
  final SearchTvseries searchTvseries;

  TvseriesSearchNotifier({required this.searchTvseries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvseriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvseries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
