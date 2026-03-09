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

//height = 932 , width= 430

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsetsGeometry.only(top: 15, left: 15, right: 15),
        child: Column(
          spacing: context.height * 0.02,
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
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SearchEmpty) {
                    return const Center(child: Text("No Movies Found"));
                  }

                  if (state is SearchSuccess) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
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

                  if (state is SearchError) {
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

// class SearchTab extends StatefulWidget {
//   const SearchTab({super.key});
//
//   @override
//   State<SearchTab> createState() => _SearchTabState();
// }
//
// class _SearchTabState extends State<SearchTab> {
//   // final MovieModel movieStatus = MovieModel();
//
//   late Future<AllMoviesResponse> moviesFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     moviesFuture = ApiManager.getAllMovies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<AllMoviesResponse>(
//       future: moviesFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: SizedBox(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: AppColors.whiteColor,
//               ),
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Text("Error snapshot");
//         }
//         if (snapshot.data?.status == "error") {
//           debugPrint("error status ");
//           return Text("Error status");
//         }
//         var moviesList = snapshot.data?.data?.movies ?? [];
//         if (moviesList.isEmpty) {
//           return Center(
//             child: Text(
//               "No Sources Found",
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//           );
//         }
//         return SafeArea(
//           bottom: false,
//           child:  Padding(
//             padding: EdgeInsetsGeometry.only(
//               top: 15,
//               left: 15,
//               right: 15,
//               // top: context.width *0.04,
//               // left: context.width *0.04,
//               // right: context.width *0.04,
//             ),
//             child: Column(
//               spacing: context.height *0.02,
//               children: [
//                 CustomTextFormField(
//                   errorStyle: TextStyle(
//                     color: AppColors.redColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   prefixIcon: SvgPicture.asset(
//                     AppAssets.bnbSearchIcon,
//                     fit: BoxFit.none,
//                   ),
//                   hintText: "search".tr(),
//                   hintStyle: AppStyles.robotoRegular16White,
//                   filled: true,
//                   fillColor: AppColors.darkGrayColor,
//                 ),
//                 Expanded(
//                   child: GridView.builder(
//                     // padding: EdgeInsets.symmetric(
//                     //   vertical: context.height * 0.02,
//                     // ),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 15,
//                       mainAxisSpacing: 15,
//                       childAspectRatio: 0.7,
//                     ),
//                     itemBuilder: (context, index) {
//                       return MovieItem(
//                         movieImage: moviesList[index].largeCoverImage!,
//                         movieRating: '${moviesList[index].rating}',
//                       );
//                     },
//                     itemCount: moviesList.length,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//         );
//       },
//     );
//   }
// }
