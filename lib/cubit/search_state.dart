import '../Api/model/inner_classes/movie.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Movie> movies;

  SearchSuccessState(this.movies);
}

class SearchEmptyState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState(this.message);
}
