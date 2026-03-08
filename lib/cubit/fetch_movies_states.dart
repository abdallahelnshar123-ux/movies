import '../Api/model/inner_classes/movie.dart';

abstract class IntialMoviesState {}

class LoadingMoviesState extends IntialMoviesState {}

class SuccessMoviesState extends IntialMoviesState {
  List<Movie>? response;
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