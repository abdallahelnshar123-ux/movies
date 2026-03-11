import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/home_screen/tabs/search_tab/widget/movie_item.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

import '../../../cubit/search_state.dart';
import '../../../cubit/search_view_model.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/screen_size.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: context.width * 0.04,
          left: context.width * 0.04,
          right: context.width * 0.04,
        ),
        child: Column(
          spacing: context.width * 0.04,
          children: [
            CustomTextFormField(
              onFieldSubmitted: (value) {
                cubit.searchMovies(value);
              },
              prefixIcon: SvgPicture.asset(
                AppAssets.bnbSearchIcon,
                fit: BoxFit.none,
              ),
              hintText: "search".tr(),
              hintStyle: AppStyles.robotoRegular16White,
              filled: true,
              fillColor: AppColors.darkGrayColor,
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmptyState) {
                    return const Center(child: Text("No Movies Found"));
                  }

                  if (state is SearchSuccessState) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: context.width * 0.04,
                        mainAxisSpacing: context.width * 0.04,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.movieDetailsScreen,
                              arguments: movie.id,
                            );
                          },
                          child: MovieItem(
                            movieImage: movie.largeCoverImage!,
                            movieRating: "${movie.rating}",
                          ),
                        );
                      },
                    );
                  }

                  if (state is SearchErrorState) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Image.asset(AppAssets.emptyListImage));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
