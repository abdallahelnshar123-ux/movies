import 'package:movies/Api/model/movie_model.dart';

abstract class IntialMoviesState {}

class LoadingMoviesState extends IntialMoviesState {}

class SuccessMoviesState extends IntialMoviesState {
  List<Movies>? response;
  SuccessMoviesState({
    required this.response
});
}

class ErrorMoviesState extends IntialMoviesState {
  String errorMessage;
  ErrorMoviesState({
    required this.errorMessage
});
}