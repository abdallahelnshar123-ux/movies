import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/cubit/movie_details_state.dart';
import 'package:movies/utils/firebase_utils.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitState());

  Future<void> getMovieDetails(int movieId, String uId) async {
    emit(MovieDetailsLoadingState());

    try {
      final response = await ApiManager.getMoviesDetails(movieId);

      final movie = response.data?.movie;

      if (movie != null) {
        await FirebaseUtils.addMovieToHistory(movie: movie, uId: uId);
        debugPrint('added to history');
        emit(MovieDetailsSuccessState(movie: movie));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(message: e.toString()));
    }
  }
}
