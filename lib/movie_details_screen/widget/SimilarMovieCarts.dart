import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../Api/Api_manager.dart';
import '../../Api/model/suggestion_response.dart';
import '../../Api/widget/main_loading_widget.dart';
import '../../utils/app_styles.dart';

class SimilarMovieWidget extends StatelessWidget {
  final int movieId;

  const SimilarMovieWidget({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SuggestionResponse>(
      future: ApiManager.getSuggestionDetails(movieId),
      builder: (context, snapshot) {
        // if (snapshot == null) {
        //   return MainLoadingWidget();
        // }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('sorry_we_were_unable_to_upload_similar_movies'.tr(),
                style: AppStyles.robotoBold20White),
          );
          //   MainErrorWidget(
          //   errorMessage: 'Something went wrong',
          //   onPressed: () {
          //     // setState(() {
          //     //   var movieSuggestion = ApiManager.getSuggestionDetails(
          //     //     widget.movie.id!,
          //     //   );
          //     // });
          //   },
          // );
        }
        final response = snapshot.data;

        if (response == null ||
            response.status == "error" ||
            response.data == null ||
            response.data!.movies == null) {
          return Center(
            child: Text('sorry_we_were_unable_to_upload_similar_movies'.tr(),
                style: AppStyles.robotoBold20White),
          );
          // return MainErrorWidget(
          //   errorMessage: "No movie data found",
          //   onPressed: () {
          //     setState(() {
          //       var movieSuggestion = ApiManager.getSuggestionDetails(
          //         widget.movie.id!,
          //       );
          //     });
          //   },
          // );
        } else {
          return GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: response.data!.movies![index]
                            .mediumCoverImage ?? '',
                        placeholder: (context, url) => MainLoadingWidget(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              response.data!.movies?[index].rating.toString() ??
                                  '',
                              style: AppStyles.robotoRegular14White,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: response.data!.movies?.length ?? 0,
          );
        }
      },
    );
  }
}
