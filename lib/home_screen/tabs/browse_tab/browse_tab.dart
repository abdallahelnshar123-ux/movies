import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/browse_state.dart';
import 'package:movies/cubit/browse_view_model.dart';
import 'package:movies/home_screen/tabs/browse_tab/widgets/genres_tab_bar.dart';
import 'package:movies/home_screen/tabs/search_tab/widget/movie_item.dart';
import 'package:movies/utils/screen_size.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late String selectedGenre = genresList[0];
  List<String> genresList = [
    'action',
    'adventure',
    'animation',
    'anime',
    'comedy',
    'crime',
    'documentary',
    'drama',
    'family',
    'fantasy',
    'horror',
    'music',
    'musical',
    'mystery',
    'reality TV',
    'romance',
    'sci-fi',
    'seasonal',
    'short',
    'sport',
    'thriller',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BrowseCubit>().getBrowseMovies(selectedGenre);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          spacing: context.width * 0.04,
          children: [
            DefaultTabController(
              length: genresList.length,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsetsDirectional.only(
                  start: context.width * 0.04,
                ),
                padding: EdgeInsetsDirectional.only(top: context.width * 0.04),
                dividerColor: AppColors.transparentColor,
                indicatorColor: AppColors.transparentColor,
                isScrollable: true,

                onTap: (index) {
                  if (selectedGenre == genresList[index]) return;

                  setState(() {
                    selectedGenre = genresList[index];
                  });

                  context.read<BrowseCubit>().getBrowseMovies(selectedGenre);
                },
                tabs: genresList
                    .map(
                      (genre) =>
                      GenresTabBar(
                        isSelected:
                        selectedGenre ==
                            genresList[genresList.indexOf(genre)],
                        category: genre,
                      ),
                )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<BrowseCubit, BrowseState>(
                builder: (context, state) {
                  if (state is BrowseErrorState) {
                    return Center(child: Text(state.message));
                  }
                  if (state is BrowseEmptyState) {
                    return const Center(
                      child: Text("No Movies Found For This Genre"),
                    );
                  }

                  if (state is BrowseSuccessState) {
                    final movies = state.movies;

                    return GridView.builder(
                      padding: EdgeInsets.only(
                        right: context.width * 0.04,
                        left: context.width * 0.04,
                        bottom: context.height * 0.1,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.width * 0.04,
                        mainAxisSpacing: context.width * 0.04,
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
                              arguments: movie.id,
                            );
                          },
                          child: MovieItem(
                            movieImage: movie.mediumCoverImage ?? '',
                            movieRating: movie.rating.toString(),
                          ),
                        );
                      },
                    );
                  }

                  return Center(

                      child: CircularProgressIndicator(

                        color: AppColors.yellowColor,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
