import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/home_screen/tabs/browse_tab/widgets/genres_tab_bar.dart';
import 'package:movies/home_screen/tabs/search_tab/widget/movie_item.dart';
import 'package:movies/utils/screen_size.dart';

import '../../../cubit/fetch_movies_states.dart';
import '../../../cubit/movies_view_model.dart';
import '../../../utils/app_routes.dart';

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

          allGenres =
              movies
                  .expand<String>(
                    (movie) => (movie.genres ?? []).cast<String>(),
                  )
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

        return SafeArea(
          maintainBottomViewPadding: true,
          bottom: false,
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: 15,

              // left: 15,
              // right: 15,
              // top: context.width *0.04,
              // left: context.width *0.04,
              // right: context.width *0.04,
            ),
            child: Column(
              spacing: context.height * 0.02,
              children: [
                if (allGenres.isNotEmpty)
                  SizedBox(
                    height: context.height * 0.065,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: allGenres.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final genre = allGenres[index];

                        return GenresTabBar(
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
                      ? Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: EdgeInsets.only(
                            right: 15,
                            left: 15,
                            bottom: context.height * 0.1,
                          ),
                          // padding: EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final movie = movies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.movieDetailsScreen,
                                  arguments: movies[index].id,
                                );
                              },
                              child: MovieItem(
                                movieImage: movie.mediumCoverImage ?? '',
                                movieRating: movie.rating.toString(),
                              ),
                            );

                            //   MovieCard(
                            //   imageUrl:
                            //   movie.mediumCoverImage ?? '',
                            //   rating: movie.rating?.toDouble(),
                            //   width: context.width,
                            //   height: context.height,
                            //   ratingTextStyle: AppStyles.robotoRegular10White,
                            // );
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
