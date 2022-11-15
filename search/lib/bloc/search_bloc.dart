import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/bloc/search_event.dart';
import 'package:search/bloc/search_state.dart';
import 'package:search/domain/usecases/movies/search_movies.dart';
import 'package:search/domain/usecases/tvseries/search_tvseries.dart';

class SearchMoviesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  EventTransformer<T> debounce<T>(Duration duration) {
    return ((events, mapper) => events.debounceTime(duration).flatMap(mapper));
  }

  SearchMoviesBloc(this._searchMovies) : super(SearchEmpty()) {
    on<onQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchMoviesHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

class SearchTvseriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTvseries _searchTvseries;

  EventTransformer<T> debounce<T>(Duration duration) {
    return ((events, mapper) => events.debounceTime(duration).flatMap(mapper));
  }

  SearchTvseriesBloc(this._searchTvseries) : super(SearchEmpty()) {
    on<onQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTvseries.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchTvseriesHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}
