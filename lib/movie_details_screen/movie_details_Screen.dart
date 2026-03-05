import 'package:flutter/material.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/widget/main_error_widget.dart';
import 'package:movies/Api/widget/main_loading_widget.dart';
import 'package:movies/movie_details_screen/movie_details_item.dart';

import '../Api/model/movie_details_response.dart';

class MovieDetailsScreen extends StatefulWidget {
  MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  int currentIndex = 0;

  // final MovieModel movieModel = MovieModel();
  Future<MovieDetailsResponse>? movieFuture;

  // List<String> cardList = [
  //   AppAssets.cardOne,
  //   AppAssets.cardTwo,
  //   AppAssets.cardThree,
  //   AppAssets.cardFour,
  // ];

  late int movieId;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!isInitialized) {
      movieId = ModalRoute.of(context)!.settings.arguments as int;
      movieFuture = ApiManager.getMoviesDetails(movieId);
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (movieFuture == null) {
    //   return MainLoadingWidget();
    // }
    return FutureBuilder<MovieDetailsResponse>(
      future: movieFuture,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return MainLoadingWidget();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        }

        if (snapshot.hasError) {
          return MainErrorWidget(
            errorMessage: 'Something went wrong',
            onPressed: () {
              setState(() {
                ApiManager.getMoviesDetails(movieId);
              });
            },
          );
        }

        final response = snapshot.data;

        if (
        // response == null ||
        //     response.status == "error" ||
        //     response.data == null ||
        response?.data?.movie == null) {
          return MainErrorWidget(
            errorMessage: "No movie data found",
            onPressed: () {
              setState(() {
                ApiManager.getMoviesDetails(movieId);
              });
            },
          );
        }

        final movie = response!.data!.movie;

        /// can't be null
        return MovieDetailsItem(movie: movie!);

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return MainLoadingWidget();
        //   // todo : server => response : error
        // } else if (snapshot.hasError) {
        //   return MainErrorWidget(
        //     errorMessage: 'Something went wrong',
        //       onPressed: () {
        //         setState(() {
        //           movieFuture = ApiManager.getMoviesDetails(movieId);
        //         });
        //       }
        //   );
        // }
        // // todo: server=> response : success, error
        // if (snapshot.data?.status == "error") {
        //   return MainErrorWidget(
        //     errorMessage: snapshot.data!.message!,
        //     onPressed: () {
        //       ApiManager.getMoviesDetails(movieId );
        //       setState(() {});
        //     },
        //   );
        // }

        // return MovieDetailsItem(movie: selectedMovie);
        // List<Movie>? movies;
        // var size = MediaQuery.of(context).size;
        //   return Scaffold(
        //     backgroundColor: AppColors.blackColor,
        //     extendBodyBehindAppBar: true,
        //     body: Column(
        //       spacing: 15,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         Stack(
        //           children: [
        //             Container(
        //               height: size.height * 0.8,
        //               width: double.infinity,
        //               decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                   image: NetworkImage(
        //                     selectedMovie[Index].backgroundImage ?? '',
        //                   ),
        //                   // Replace with your image
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //
        //             ),
        //             Container(
        //               height: size.height * 0.8,
        //               width: double.infinity,
        //               decoration: BoxDecoration(
        //                 gradient: LinearGradient(
        //                   begin: Alignment.topCenter,
        //                   end: Alignment.bottomCenter,
        //                   colors: [
        //                     AppColors.blackColor.withAlpha(153),
        //                     AppColors.blackColor.withAlpha(230),
        //                   ],
        //                   stops: [
        //                     0.3,
        //                     0.95,
        //                   ], // Adjust the gradient transition point
        //                 ),
        //               ),
        //             ),
        //             Column(
        //               children: [
        //                 Padding(
        //                   padding: EdgeInsets.only(top: context.height * 0.05),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       IconButton(
        //                         iconSize: 30,
        //                         onPressed: () => Navigator.pop(context),
        //                         icon: const Icon(
        //                           Icons.arrow_back_ios_rounded,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                       IconButton(
        //                         iconSize: 30,
        //                         onPressed: () {
        //                           setState(() {
        //                             isBookMarked = !isBookMarked;
        //                           });
        //                         },
        //                         icon: Icon(
        //                           isBookMarked
        //                               ? Icons.bookmark
        //                               : Icons.bookmark_border,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                       ]
        //                   ),
        //   ),
        //                     SizedBox(height: size.height * 0.09),
        //
        //                   Image.asset(AppAssets.playMovieImage),
        //
        //                       //todo:Movie description
        //                       Text(
        //                         widget.movie?.titleLong??'',
        //                         style: AppStyles.robotoBold24White,
        //                         textAlign: TextAlign.center,
        //                       ),
        //
        //               ],
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   );
      },
    );
    // var size = MediaQuery.of(context).size;
    // return Scaffold(
    //   backgroundColor: AppColors.blackColor,
    //   extendBodyBehindAppBar: true,
    //   body: SingleChildScrollView(
    //     child: Column(
    //       spacing: 15,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Container(
    //           child: Stack(
    //             children: [
    //               Container(
    //                 height: size.height * 0.8,
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                     image: AssetImage(
    //                       AppAssets.doctorStrangeImg,
    //                     ), // Replace with your image
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 height: size.height * 0.8,
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   gradient: LinearGradient(
    //                     begin: Alignment.topCenter,
    //                     end: Alignment.bottomCenter,
    //                     colors: [
    //                       AppColors.blackColor.withAlpha(153),
    //                       AppColors.blackColor.withAlpha(230),
    //                     ],
    //                     stops: [
    //                       0.3,
    //                       0.95,
    //                     ], // Adjust the gradient transition point
    //                   ),
    //                 ),
    //               ),
    //               Column(
    //                 spacing: 10,
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 children: [
    //                   Padding(
    //                     padding: EdgeInsets.only(top: context.height * 0.05),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         IconButton(
    //                           iconSize: 30,
    //                           onPressed: () => Navigator.pop(context),
    //                           icon: const Icon(
    //                             Icons.arrow_back_ios_rounded,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                         IconButton(
    //                           iconSize: 30,
    //                           onPressed: () {
    //                             setState(() {
    //                               isBookMarked = !isBookMarked;
    //                             });
    //                           },
    //                           icon: Icon(
    //                             isBookMarked
    //                                 ? Icons.bookmark
    //                                 : Icons.bookmark_border,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SizedBox(height: size.height * 0.09),
    //                   Image.asset(AppAssets.playMovieImage),
    //
    //                   ///todo:Movie description
    //                   Text(
    //                     "Doctor Strange in The Multiverse of Madness",
    //                     style: AppStyles.robotoBold24White,
    //                     textAlign: TextAlign.center,
    //                   ),
    //
    //                   ///todo:Movie production Year
    //                   Text(
    //                     "2022",
    //                     style: AppStyles.robotoBold20LightGray,
    //                     textAlign: TextAlign.center,
    //                   ),
    //
    //                   ///todo: Watch Button
    //                   Padding(
    //                     padding: EdgeInsets.symmetric(
    //                       horizontal: context.width * 0.02,
    //                     ),
    //                     child: ElevatedButton(
    //                       onPressed: () {
    //                         debugPrint(widget.movieId.toString());
    //                       },
    //                       style: ElevatedButton.styleFrom(
    //                         padding: EdgeInsets.symmetric(
    //                           vertical: size.height * 0.015,
    //                         ),
    //                         backgroundColor: AppColors.redColor,
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(16),
    //                           side: BorderSide.none,
    //                         ),
    //                       ),
    //                       child: Text(
    //                         "Watch",
    //                         style: AppStyles.robotoBold20White,
    //                         textAlign: TextAlign.center,
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    //           child: Column(
    //             spacing: 15,
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               ///todo: Fav Container , Movie Time Container , Rating Container
    //               Row(
    //                 spacing: 11,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Expanded(
    //                     child: ratingWidget(
    //                       text: '15',
    //                       icon: AppAssets.starIcon,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: ratingWidget(
    //                       text: '90',
    //                       icon: AppAssets.clockIcon,
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: ratingWidget(
    //                       text: '7.5',
    //                       icon: AppAssets.heartIcon,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               TitleWidget(text: "Screen Shots"),
    //               Screenshotswidget(),
    //               TitleWidget(text: "Similar"),
    //               Similarmoviecarts(cardList: cardList),
    //               TitleWidget(text: "Summary"),
    //               RichText(
    //                 text: TextSpan(
    //                   style: AppStyles.robotoRegular16White.copyWith(
    //                     height: 1.5,
    //                   ),
    //                   children: [
    //                     const TextSpan(
    //                       text:
    //                           "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.",
    //                     ),
    //                     TextSpan(
    //                       text: " —Blazer346",
    //                       style: AppStyles.robotoRegular16White.copyWith(
    //                         color: AppColors.lightGrayColor,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               TitleWidget(text: 'Cast'),
    //               ListView.separated(
    //                 physics: NeverScrollableScrollPhysics(),
    //                 shrinkWrap: true,
    //                 padding: EdgeInsets.zero,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                     padding: EdgeInsetsDirectional.only(
    //                       start: size.width * 0.02,
    //                       bottom: size.height * 0.01,
    //                       top: size.height * 0.01,
    //                     ),
    //                     decoration: BoxDecoration(
    //                       color: AppColors.darkGrayColor,
    //                       borderRadius: BorderRadius.circular(16),
    //                     ),
    //                     child: Row(
    //                       spacing: 10,
    //                       children: [
    //                         Image.asset(castMan[index].image),
    //                         Expanded(
    //                           child: Column(
    //                             spacing: 2,
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Row(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //
    //                                 children: [
    //                                   Text(
    //                                     context.tr('name:'),
    //                                     style: AppStyles.robotoRegular14White,
    //                                   ),
    //                                   Expanded(
    //                                     child: Text(
    //                                       castMan[index].name.trimRight(),
    //                                       style: AppStyles.robotoRegular14White,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               Row(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     context.tr('character'),
    //                                     style: AppStyles.robotoRegular14White,
    //                                   ),
    //                                   Expanded(
    //                                     child: Text(
    //                                       castMan[index].character.trimRight(),
    //                                       style: AppStyles.robotoRegular14White,
    //                                       maxLines: 3,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //                 separatorBuilder: (context, index) {
    //                   return SizedBox(height: size.height * 0.02);
    //                 },
    //                 itemCount: castMan.length,
    //               ),
    //               TitleWidget(text: 'Genres'),
    //               GridView.builder(
    //                 padding: EdgeInsets.zero,
    //                 physics: NeverScrollableScrollPhysics(),
    //                 shrinkWrap: true,
    //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 3, // tables count
    //                   mainAxisSpacing: 10,
    //                   crossAxisSpacing: 10,
    //                   childAspectRatio: 2.5,
    //                 ),
    //                 itemBuilder: (context, index) {
    //                   return GenresWidget(text: 'Action');
    //                 },
    //                 itemCount: 5,
    //               ),
    //               SizedBox(height: size.height * 0.005),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
