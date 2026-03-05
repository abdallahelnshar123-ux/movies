import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/model/movie_model.dart';
import 'package:movies/home_screen/tabs/home_tab/movie_card.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';

class HomeUi extends StatelessWidget {
   List<Movies> movies;
   int currentIndex;
   Function(int) onPageChanged;

   HomeUi({
    super.key,
    required this.movies,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movies[currentIndex].largeCoverImage ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(color: const Color(0xB3000000)),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.height * 0.05),
                Image.asset(AppAssets.availableNowImage),
                SizedBox(height: context.height * 0.03),

                CarouselSlider.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index, realIndex) {
                    return MovieCard(
                      imageUrl: movies[index].largeCoverImage ?? "",
                      rating: movies[index].rating,
                      width: double.infinity,
                      height: context.height * 0.50,
                      ratingTextStyle: AppStyles.robotoRegular16White,
                      starSize: 22,
                      margin: EdgeInsets.symmetric(
                          horizontal: context.width * 0.01),
                      badgeTop: context.height * 0.02,
                      badgeLeft: context.width * 0.03,
                      badgeColor: const Color(0x66000000),
                      badgePadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    );
                  },
                  options: CarouselOptions(
                    height: context.height * 0.45,
                    enlargeCenterPage: true,
                    viewportFraction: 0.7,
                    onPageChanged: (index, reason) {
                      onPageChanged(index);
                    },
                  ),
                ),

                SizedBox(height: context.height * 0.02),
                Image.asset(AppAssets.watchNowImage),
                SizedBox(height: context.height * 0.02),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movies[currentIndex].genres![0],
                          style: AppStyles.robotoRegular20White),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See More",
                              style: AppStyles.robotoRegular16Yellow,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: AppColors.yellowColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.height * 0.015),

                SizedBox(
                  height: context.height * 0.15,
                  child: ListView.builder(
                    padding:
                    EdgeInsets.only(left: context.width * 0.02),
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: context.width * 0.03,
                        ),
                        width: context.width * 0.25,
                        child: MovieCard(
                          imageUrl:
                          movies[index].largeCoverImage ?? "",
                          rating: movies[index].rating,
                          width: context.width * 0.25,
                          height: context.height * 0.15,
                          ratingTextStyle:
                          AppStyles.robotoRegular10White,
                          starSize: 14,
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: context.height * 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}