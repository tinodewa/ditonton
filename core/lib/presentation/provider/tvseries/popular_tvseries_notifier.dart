import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_popular_tvseries.dart';
import 'package:flutter/foundation.dart';

class PopularTvseriesNotifier extends ChangeNotifier {
  final GetPopularTvseries getPopularTvseries;

  PopularTvseriesNotifier(this.getPopularTvseries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvseries = [];
  List<TvSeries> get tvseries => _tvseries;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvseries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvseries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvseriesData) {
        _tvseries = tvseriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
