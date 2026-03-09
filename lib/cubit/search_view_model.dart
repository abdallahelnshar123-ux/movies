import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/search_state.dart';

import '../../Api/Api_manager.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchMovies(String searchText) async {
    if (searchText.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final response = await ApiManager.getMoviesBySearch(searchText);

      final movies = response.data?.movies ?? [];

      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
