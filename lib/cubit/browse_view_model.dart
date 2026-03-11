import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/browse_state.dart';

import '../../Api/Api_manager.dart';

/// todo :   modify

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitialState());

  Future<void> getBrowseMovies(String genre) async {
    // if (searchText.trim().isEmpty) {
    //   emit(SearchInitialState());
    //   return;
    // }

    emit(BrowseLoadingState());

    try {
      final response = await ApiManager.getMoviesByGenre(genre, 20);

      final movies = response.data?.movies ?? [];

      if (movies.isEmpty) {
        emit(BrowseEmptyState());
      } else {
        emit(BrowseSuccessState(movies));
      }
    } catch (e) {
      emit(BrowseErrorState(e.toString()));
    }
  }
}
