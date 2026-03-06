import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/model/movie_details_response.dart';
import 'package:movies/movie_details_screen/widget/SimilarMovieCarts.dart';
import 'package:movies/movie_details_screen/widget/cast_widget.dart';
import 'package:movies/movie_details_screen/widget/genres_widget.dart';
import 'package:movies/movie_details_screen/widget/rating_widget.dart';
import 'package:movies/movie_details_screen/widget/screenShotsWidget.dart';
import 'package:movies/movie_details_screen/widget/summary_widget.dart';
import 'package:movies/movie_details_screen/widget/title_widget.dart';
import 'package:movies/widgets/custom_elevated_button.dart';

import '../Api/model/inner_classes/movie.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/screen_size.dart';

class MovieDetailsItem extends StatefulWidget {
  bool isBookMarked = true;

  // final MovieSuggestionResponse? movieSuggestionResponse;
  // final details_model.MovieDetailsResponse? movieDetailsResponse;

  final Movie movie;

  MovieDetailsItem({
    super.key,
    required this.movie,
    // this.movieDetailsResponse,
    // this.movieSuggestionResponse,
  });

  @override
  State<MovieDetailsItem> createState() => _MovieDetailsItemState();
}

class _MovieDetailsItemState extends State<MovieDetailsItem> {
  late List<Cast> castList = widget.movie.cast ?? [];
  late List<String> genresList = widget.movie.genres ?? [];

  late List<String> screenShotsList = [
    widget.movie.largeScreenshotImage1 ??
        widget.movie.mediumScreenshotImage1 ??
        '',
    widget.movie.largeScreenshotImage2 ??
        widget.movie.mediumScreenshotImage2 ??
        '',
    widget.movie.largeScreenshotImage3 ??
        widget.movie.mediumScreenshotImage3 ??
        '',
  ];

  // widget.movieDetailsResponse?.data?.movie?.cast;
  // late var torrentsList = widget.movie.torrents ?? [];
  // late var gestureList = widget.movie.genres ?? [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.network(
                widget.movie.largeCoverImage ?? '',
                fit: BoxFit.fitWidth,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
                alignment: Alignment.topCenter,
                height: context.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.blackColor,
                      AppColors.blackColor.withAlpha(230),
                      AppColors.transparentColor,
                    ],
                    stops: [0.2, 0.3, 1],
                  ),
                  // image: DecorationImage(
                  //
                  //   alignment: Alignment.topCenter,
                  //   image: NetworkImage(),
                  //
                  //   fit: BoxFit.fitWidth,
                  // ),
                ),
                // foregroundDecoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //     colors: [
                //       AppColors.blackColor,
                //       AppColors.blackColor.withAlpha(230),
                //       AppColors.transparentColor,
                //     ],
                //     stops: [0.2, 0.3, 1],
                //   ),
                // ),
                child: Column(
                  spacing: 15,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: context.height * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 30,
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                widget.isBookMarked = !widget.isBookMarked;
                              });
                            },
                            icon: Icon(
                              widget.isBookMarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height * 0.15),

                    // SizedBox(height: context.height * 0.2),
                    Image.asset(AppAssets.playMovieImage),

                    Spacer(),

                    //todo:Movie title
                    Text(
                      widget.movie.titleEnglish ?? 'no title',
                      style: AppStyles.robotoBold24White,
                      textAlign: TextAlign.center,
                    ),

                    // SizedBox(height: context.height * 0.03),
                    //todo:Movie year
                    Text(
                      widget.movie.year.toString(),
                      style: AppStyles.robotoBold20LightGray,
                      textAlign: TextAlign.center,
                    ),

                    // SizedBox(height: context.height * 0.03),

                    ///todo: Watch Button
                    CustomElevatedButton(
                      decorationColor: AppColors.redColor,
                      onPressed: () {
                        debugPrint(widget.movie.title);
                      },
                      child: Text(
                        "watch".tr(),
                        style: AppStyles.robotoBold20White,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // ElevatedButton(
                    //   onPressed: () {
                    //     debugPrint(widget.movie.toString());
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.symmetric(
                    //       vertical: context.height * 0.015,
                    //     ),
                    //     backgroundColor: AppColors.redColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16),
                    //       side: BorderSide.none,
                    //     ),
                    //   ),
                    //   child: Text(
                    //     "Watch",
                    //     style: AppStyles.robotoBold20White,
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // SizedBox(height: context.height * 0.03),
                    Row(
                      spacing: 11,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ratingWidget(
                          text: widget.movie.likeCount.toString(),
                          icon: AppAssets.heartIcon,
                        ),
                        ratingWidget(
                          text: widget.movie.runtime.toString(),
                          icon: AppAssets.clockIcon,
                        ),
                        ratingWidget(
                          text: widget.movie.rating.toString(),
                          icon: AppAssets.starIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  context.width * 0.02,
                  0,
                  context.width * 0.02,
                  context.width * 0.02,
                ),
                child: Column(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ///todo: Fav Container , Movie Time Container , Rating Container
                    TitleWidget(text: "screen_shots".tr()),
                    ScreenShotsWidget(screenShotsList: screenShotsList ?? []),
                    TitleWidget(text: "similar".tr()),
                    // todo :  similar
                    SimilarMovieWidget(movieId: widget.movie.id!),
                    TitleWidget(text: "Summary"),
                    SummaryWidget(
                      summary:
                          widget.movie.descriptionFull ??
                          'sorry_no_summary_found'.tr(),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     style: AppStyles.robotoRegular16White.copyWith(
                    //       height: 1.5,
                    //     ),
                    //     children: [
                    //       const TextSpan(
                    //         text:
                    //         "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.",
                    //       ),
                    //       TextSpan(
                    //         text: " —Blazer346",
                    //         style: AppStyles.robotoRegular16White.copyWith(
                    //           color: AppColors.lightGrayColor,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    TitleWidget(text: 'cast'.tr()),

                    // todo : cast Widget
                    CastWidget(castList: castList),
                    TitleWidget(text: 'Genres'),
                    GenresWidget(genresList: genresList),
                    // SizedBox(height: context.height * 0.005),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
