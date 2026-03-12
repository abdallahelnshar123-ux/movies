import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/auth_view_model.dart';
import 'package:movies/cubit/movie_details_state.dart';
import 'package:movies/cubit/movie_details_view_model.dart';
import 'package:movies/movie_details_screen/movie_details_item.dart';

import '../utils/app_colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  late int movieId;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      movieId = ModalRoute.of(context)!.settings.arguments as int;
      String uId = context.read<AuthCubit>().currentUser!.id;

      context.read<MovieDetailsCubit>().getMovieDetails(movieId, uId);

      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsErrorState) {
          return Center(child: Text(state.message));
        }

        if (state is MovieDetailsSuccessState) {
          final movie = state.movie;

          return MovieDetailsItem(movie: movie);
        }

        return Center(
          child: CircularProgressIndicator(color: AppColors.yellowColor),
        );
      },
    );
  }
}

/*

 FutureBuilder<MovieDetailsResponse>(
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
 */
