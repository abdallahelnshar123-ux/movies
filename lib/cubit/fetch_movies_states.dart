import '../Api/model/inner_classes/movie.dart';

abstract class MoviesState {}

class LoadingMoviesState extends MoviesState {}

class SuccessMoviesState extends MoviesState {
  List<Movie>? response;
  SuccessMoviesState({
    required this.response
});
}

class ErrorMoviesState extends MoviesState {
  String errorMessage;
  ErrorMoviesState({
    required this.errorMessage
});
}