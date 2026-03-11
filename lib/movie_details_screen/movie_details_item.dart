import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/model/movie_details_response.dart';
import 'package:movies/movie_details_screen/widget/SimilarMovieCarts.dart';
import 'package:movies/movie_details_screen/widget/book_mark_widget.dart';
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
  final bool isBookMarked = true;

  final Movie movie;

  const MovieDetailsItem({super.key, required this.movie});

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
                      Colors.black,
                      AppColors.blackColor.withAlpha(230),
                      AppColors.transparentColor,
                    ],
                    stops: [0.15, 0.3, 1],
                  ),
                ),
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
                          BookMarkWidget(movie: widget.movie),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height * 0.15),
                    Image.asset(AppAssets.playMovieImage),
                    Spacer(),
                    //todo:Movie title
                    Text(
                      widget.movie.titleEnglish ?? 'no title',
                      style: AppStyles.robotoBold24White,
                      textAlign: TextAlign.center,
                    ),
                    //todo:Movie year
                    Text(
                      widget.movie.year.toString(),
                      style: AppStyles.robotoBold20LightGray,
                      textAlign: TextAlign.center,
                    ),

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

          Padding(
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
                TitleWidget(text: 'cast'.tr()),

                // todo : cast Widget
                    CastWidget(castList: castList),
                    TitleWidget(text: 'Genres'),
                    GenresWidget(genresList: genresList),
                  ],

                ),
              ),
        ],
      ),
    );
  }
}
