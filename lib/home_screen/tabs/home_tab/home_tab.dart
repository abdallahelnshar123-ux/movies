import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/model/all_movies_response.dart';
import 'package:movies/home_screen/tabs/home_tab/widget/genre_movies_widget.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;

  late Future<AllMoviesResponse> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = ApiManager.getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AllMoviesResponse>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.whiteColor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error snapshot");
        }
        if (snapshot.data?.status == "error") {
          debugPrint("error status ");
          return Text("Error status");
        }
        var moviesList = snapshot.data?.data?.movies ?? [];
        if (moviesList.isEmpty) {
          return Center(
            child: Text(
              "No Sources Found",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        }
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  moviesList[currentIndex].largeCoverImage ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Container(color: Color(0xB3000000)),
                ),
              ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: context.height * 0.05),
                    Image.asset(AppAssets.availableNowImage),
                    SizedBox(height: context.height * 0.03),
                    CarouselSlider.builder(
                      itemCount: moviesList.length,
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.movieDetailsScreen,
                              arguments: moviesList[index].id,
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: context.width * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      moviesList[index].largeCoverImage ?? "",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: context.height * 0.02,
                                left: context.width * 0.03,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0x66000000),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        moviesList[index].rating?.toString() ??
                                            "unrated",
                                        style: AppStyles.robotoRegular16White,
                                      ),
                                      SizedBox(width: context.width * 0.01),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: context.height * 0.45,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: context.height * 0.02),
                    Image.asset(AppAssets.watchNowImage),
                    SizedBox(height: context.height * 0.02),
                    GenreMoviesWidget(),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: context.width * 0.03,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Action", style: AppStyles.robotoRegular20White),
                    //       Row(
                    //         children: [
                    //           TextButton(
                    //             onPressed: () {},
                    //             child: Text(
                    //               "See More",
                    //               style: AppStyles.robotoRegular16Yellow,
                    //             ),
                    //           ),
                    //           Icon(
                    //             Icons.arrow_forward_outlined,
                    //             color: AppColors.yellowColor,
                    //             size: 18,
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: context.height * 0.015),
                    //
                    // /// Horizontal Movies List
                    // SizedBox(
                    //   height: context.height * 0.15,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(left: context.width * 0.02),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: moviesList.length,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         margin: EdgeInsets.only(
                    //           right: context.width * 0.03,
                    //         ),
                    //         width: context.width * 0.25,
                    //         child: Stack(
                    //           children: [
                    //             ClipRRect(
                    //               borderRadius: BorderRadius.circular(20),
                    //               child: Image.network(
                    //                 moviesList[index].largeCoverImage ?? "",
                    //                 fit: BoxFit.cover,
                    //                 width: context.width * 0.25,
                    //                 height: context.height * 0.15,
                    //               ),
                    //             ),
                    //             Positioned(
                    //               top: 6,
                    //               left: 6,
                    //               child: Container(
                    //                 padding: EdgeInsets.symmetric(
                    //                   horizontal: 6,
                    //                   vertical: 3,
                    //                 ),
                    //                 decoration: BoxDecoration(
                    //                   color: Color(0xB3000000),
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Row(
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   children: [
                    //                     Text(
                    //                       moviesList[index].rating
                    //                               ?.toStringAsFixed(1) ??
                    //                           "unrated",
                    //                       style: AppStyles.robotoRegular10White,
                    //                     ),
                    //                     SizedBox(width: 3),
                    //                     Icon(
                    //                       Icons.star,
                    //                       color: Colors.amber,
                    //                       size: 14,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    //
                    // SizedBox(height: context.height * 0.1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      // child: BlocBuilder<MoviesCubit, IntialMoviesState>(
      //   bloc: cubit,
      //   builder: (context, state) {
      //     if (state is SuccessMoviesState) {
      //       return HomeUi(
      //         movies: state.response!,
      //         currentIndex: currentIndex,
      //         onPageChanged: (index) {
      //           setState(() {
      //             currentIndex = index;
      //           });
      //         },
      //       );
      //     }

      // return SizedBox();
    );
  }
}
