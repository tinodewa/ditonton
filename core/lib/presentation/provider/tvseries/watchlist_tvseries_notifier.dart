import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/tvseries/get_warchlist_tvseries.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvseriesNotifier extends ChangeNotifier {
  var _watchlistTvseries = <TvSeries>[];
  List<TvSeries> get watchlistTvseries => _watchlistTvseries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvseriesNotifier({required this.getWatchlistTvseries});

  final GetWatchlistTvseries getWatchlistTvseries;

  Future<void> fetchWatchlistTvseries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvseries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvseriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvseries = tvseriesData;
        notifyListeners();
      },
    );
  }
}
