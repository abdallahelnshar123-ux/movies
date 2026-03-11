import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Api/Api_manager.dart';

import 'fetch_movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(LoadingMoviesState());
  Future<void> getMovies() async {
   try{
     emit(LoadingMoviesState());
     await Future.delayed(Duration(seconds: 1));
      var response = await ApiManager.getAllMovies();
      print(response.data!.movies);
     if(response.status == "error"){
       print("error");
       emit(ErrorMoviesState(errorMessage: "Something is Wrong"));
     }
     else {
       print("Success");
       emit(SuccessMoviesState(response: response.data!.movies));
     }
   }catch(e){
     emit(ErrorMoviesState(errorMessage: "Something other is Wrong"));
   }
  }

  Future<void> getMoviesByGenre(String genre) async {
    emit(LoadingMoviesState());
    try {
      final response = await ApiManager.getMoviesByGenre(genre, 20);
      emit(SuccessMoviesState(response:response.data?.movies));
    } catch (e) {
      emit(ErrorMoviesState(errorMessage: "Something other is Wrong"));
    }
  }
}