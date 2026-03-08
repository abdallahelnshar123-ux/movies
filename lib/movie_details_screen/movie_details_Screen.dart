import 'package:flutter/material.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/widget/main_error_widget.dart';
import 'package:movies/Api/widget/main_loading_widget.dart';
import 'package:movies/movie_details_screen/movie_details_item.dart';

import '../Api/model/movie_details_response.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int currentIndex = 0;

  Future<MovieDetailsResponse>? movieFuture;

  late int movieId;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isInitialized) {
      movieId = ModalRoute.of(context)!.settings.arguments as int;
      movieFuture = ApiManager.getMoviesDetails(movieId);
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetailsResponse>(
      future: movieFuture,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return MainLoadingWidget();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }

        if (snapshot.hasError) {
          return MainErrorWidget(
            errorMessage: 'Something went wrong',
            onPressed: () {
              setState(() {
                ApiManager.getMoviesDetails(movieId);
              });
            },
          );
        }

        final response = snapshot.data;

        if (response?.data?.movie == null) {
          return MainErrorWidget(
            errorMessage: "No movie data found",
            onPressed: () {
              setState(() {
                ApiManager.getMoviesDetails(movieId);
              });
            },
          );
        }

        final movie = response!.data!.movie;

        /// can't be null
        return MovieDetailsItem(movie: movie!);
      },
    );
  }
}
