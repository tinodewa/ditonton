import 'package:core/domain/repositories/tvseries_repository.dart';

class GetWatchListStatusTvseries {
  final TvseriesRepository repository;

  GetWatchListStatusTvseries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvseries(id);
  }
}
