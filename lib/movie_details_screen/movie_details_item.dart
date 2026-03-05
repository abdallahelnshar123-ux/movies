import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/model/Movie_suggestion_response.dart';
import 'package:movies/Api/model/Movies.dart';
import 'package:movies/Api/model/movie_model.dart';
import 'package:movies/movie_details_screen/widget/SimilarMovieCarts.dart';
import 'package:movies/movie_details_screen/widget/genres_widget.dart';
import 'package:movies/movie_details_screen/widget/rating_widget.dart';
import 'package:movies/movie_details_screen/widget/screenShotsWidget.dart';
import 'package:movies/movie_details_screen/widget/title.dart';
import 'package:movies/Api/model/movie_model.dart' as movie_model;
import '../Api/model/movie_details_response.dart' as details_model;
import '../Api/widget/main_error_widget.dart';
import '../Api/widget/main_loading_widget.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/screen_size.dart';

class MovieDetailsItem extends StatefulWidget {
  bool isBookMarked = true;
  final MovieSuggestionResponse? movieSuggestionResponse;
  final details_model.MovieDetailsResponse? movieDetailsResponse;

  final Movie movie;

  MovieDetailsItem({
    super.key,
    required this.movie,
    this.movieDetailsResponse,
    this.movieSuggestionResponse,
  });

  @override
  State<MovieDetailsItem> createState() => _MovieDetailsItemState();
}

class _MovieDetailsItemState extends State<MovieDetailsItem> {
  late List<details_model.Cast>? castMan = widget.movieDetailsResponse?.data?.movie?.cast;
  late var torrentsList = widget.movie.torrents ?? [];
  late var gestureList = widget.movie.genres ?? [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.movie.largeCoverImage ?? ''),
                    // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: size.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.blackColor.withAlpha(153),
                      AppColors.blackColor.withAlpha(230),
                    ],
                    stops: [0.3, 0.95], // Adjust the gradient transition point
                  ),
                ),
              ),
              Column(
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
                  SizedBox(height: size.height * 0.2),

                  Image.asset(AppAssets.playMovieImage),

                  SizedBox(height: size.height * 0.1),

                  //todo:Movie description
                  Text(
                    widget.movie.titleEnglish ?? '',
                    style: AppStyles.robotoBold24White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.03),
                  //todo:Movie year
                  Text(
                    widget.movie.year.toString() ?? '',
                    style: AppStyles.robotoBold20LightGray,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: size.height * 0.03),

                  ///todo: Watch Button
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.02,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          debugPrint(widget.movie.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.015,
                          ),
                          backgroundColor: AppColors.redColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide.none,
                          ),
                        ),
                        child: Text(
                          "Watch",
                          style: AppStyles.robotoBold20White,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                    ),
                    child: Column(
                      spacing: 15,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ///todo: Fav Container , Movie Time Container , Rating Container
                        Row(
                          spacing: 11,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ratingWidget(
                                text: widget.movie.runtime.toString(),
                                icon: AppAssets.heartIcon,
                              ),
                            ),
                            Expanded(
                              child: ratingWidget(
                                text: widget.movie.runtime.toString(),
                                icon: AppAssets.clockIcon,
                              ),
                            ),
                            Expanded(
                              child: ratingWidget(
                                text: widget.movie.rating.toString(),
                                icon: AppAssets.starIcon,
                              ),
                            ),
                          ],
                        ),
                        TitleWidget(text: "Screen Shots"),
                        Screenshotswidget(),
                        TitleWidget(text: "Similar"),
                        FutureBuilder<MovieSuggestionResponse>(
                          future: ApiManager.getSuggestionDetails(
                            widget.movie.id!,
                          ),
                          builder: (context, snapshot) {
                            // if (snapshot == null) {
                            //   return MainLoadingWidget();
                            // }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return MainLoadingWidget();
                            }
                            if (snapshot.hasError) {
                              return MainErrorWidget(
                                errorMessage: 'Something went wrong',
                                onPressed: () {
                                  setState(() {
                                    var movieSuggestion =
                                        ApiManager.getSuggestionDetails(
                                          widget.movie.id!,
                                        );
                                  });
                                },
                              );
                            }
                            final response = snapshot.data;

                            if (response == null ||
                                response.status == "error" ||
                                response.data == null ||
                                response.data!.movies == null ||
                                response.data!.movies == null) {
                              return MainErrorWidget(
                                errorMessage: "No movie data found",
                                onPressed: () {
                                  setState(() {
                                    var movieSuggestion =
                                        ApiManager.getSuggestionDetails(
                                          widget.movie.id!,
                                        );
                                  });
                                },
                              );
                            } else {
                              return Similarmoviecarts(
                                movie: response.data!.movies!,
                              );
                            }
                          },
                        ),
                        TitleWidget(text: "Summary"),
                        RichText(
                          text: TextSpan(
                            style: AppStyles.robotoRegular16White.copyWith(
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.",
                              ),
                              TextSpan(
                                text: " —Blazer346",
                                style: AppStyles.robotoRegular16White.copyWith(
                                  color: AppColors.lightGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TitleWidget(text: 'Cast'),
                                      ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsetsDirectional.only(
                                              start: size.width * 0.02,
                                              bottom: size.height * 0.01,
                                              top: size.height * 0.01,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.darkGrayColor,
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                Image.asset(castMan[index].image),
                                                Expanded(
                                                  child: Column(
                                                    spacing: 2,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,

                                                        children: [
                                                          Text(
                                                            context.tr('name:'),
                                                            style: AppStyles.robotoRegular14White,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              castMan![index].name!,
                                                              style: AppStyles.robotoRegular14White,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            context.tr('character'),
                                                            style: AppStyles.robotoRegular14White,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              castMan![index].characterName!,
                                                              style: AppStyles.robotoRegular14White,
                                                              maxLines: 3,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (BuildContext context, int index) {
                                          return SizedBox(
                                            height: size.height*0.02,
                                          );
                                        },
                                        itemCount: castMan!.length,
                  ),
                        TitleWidget(text: 'Genres'),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // tables count
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2.5,
                              ),
                          itemBuilder: (context, index) {
                            return GenresWidget(
                              movie: widget.movie,
                              index: index,
                            );
                          },
                          itemCount: widget.movie.genres?.length ?? 0,
                        ),
                        SizedBox(height: size.height * 0.005),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
