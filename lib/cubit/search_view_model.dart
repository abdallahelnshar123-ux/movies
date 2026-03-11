import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/search_state.dart';

import '../../Api/Api_manager.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  Future<void> searchMovies(String searchText) async {
    if (searchText.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }

    emit(SearchLoadingState());

    try {
      final response = await ApiManager.getMoviesBySearch(searchText);

      final movies = response.data?.movies ?? [];

      if (movies.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchSuccessState(movies));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
