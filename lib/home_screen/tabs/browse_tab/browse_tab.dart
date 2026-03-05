import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/home_screen/tabs/browse_tab/widgets/tab_custom.dart';
import 'package:movies/utils/screen_size.dart';

import '../../../Api/model/movie_model.dart';
import '../../../cubit/fetch_movies_states.dart';
import '../../../cubit/movies_view_model.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/dialog_utils.dart';
import '../home_tab/movie_card.dart';

class BrowseTab extends StatefulWidget {
  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final MoviesCubit cubit = MoviesCubit();

  String selectedGenre = '';

  @override
  void initState() {
    super.initState();
    cubit.getMovies(); // first load
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, IntialMoviesState>(
      bloc: cubit,
      builder: (context, state) {

        List movies = [];
        List<String> allGenres = [];

        if (state is SuccessMoviesState) {
          movies = state.response ?? [];

          allGenres = movies
              .expand<String>((movie) =>
              (movie.genres ?? []).cast<String>())
              .toSet()
              .toList()
            ..sort();
          
          if (selectedGenre.isEmpty && allGenres.isNotEmpty) {
            selectedGenre = allGenres.first;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              cubit.getMoviesByGenre(selectedGenre);
            });
          }
        }

        return Scaffold(
          body: SafeArea(
            child: Column(
              spacing: 10,
              children: [
                if (allGenres.isNotEmpty)
                  SizedBox(
                    height: context.height * 0.05,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: allGenres.length,
                      separatorBuilder: (_, __) =>
                       SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final genre = allGenres[index];

                        return TabCustom(
                          isSelected: selectedGenre == genre,
                          category: genre,
                          onTap: () {
                            if (selectedGenre == genre) return;

                            setState(() {
                              selectedGenre = genre;
                            });

                            cubit.getMoviesByGenre(genre);
                          },
                        );
                      },
                    ),
                  ),
                Expanded(
                  child: state is LoadingMoviesState
                      ?  Center(
                    child: CircularProgressIndicator(),
                  )
                      : GridView.builder(
                    padding:  EdgeInsets.all(16),
                    gridDelegate:
                     SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(
                        imageUrl:
                        movie.mediumCoverImage ?? '',
                        rating: movie.rating?.toDouble(),
                        width: context.width,
                        height: context.height,
                        ratingTextStyle: AppStyles.robotoRegular10White,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
