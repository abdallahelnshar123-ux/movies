import '../Api/model/inner_classes/movie.dart';

abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final List<Movie> movies;

  BrowseSuccessState(this.movies);
}

class BrowseEmptyState extends BrowseState {}

class BrowseErrorState extends BrowseState {
  final String message;

  BrowseErrorState(this.message);
}
