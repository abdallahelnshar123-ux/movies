import 'package:flutter/material.dart';
import 'package:movies/movie_detials_screen/model/cast.dart';
import 'package:movies/movie_detials_screen/widget/SimilarMovieCarts.dart';
import 'package:movies/movie_detials_screen/widget/genreswidget.dart';
import 'package:movies/movie_detials_screen/widget/ratingWidget.dart';
import 'package:movies/movie_detials_screen/widget/screenShotsWidget.dart';
import 'package:movies/movie_detials_screen/widget/title.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class MovieDeitalsScreen extends StatefulWidget {
  const MovieDeitalsScreen({super.key});

  @override
  State<MovieDeitalsScreen> createState() => _MovieDeitalsScreenState();
}

class _MovieDeitalsScreenState extends State<MovieDeitalsScreen> {
  bool isBookMarked = true;
  List<String> cardList = [
    AppAssets.cardOne,
    AppAssets.cardTwo,
    AppAssets.cardThree,
    AppAssets.cardFour,
  ];
  List<cast> castMan = [
    cast(
      name: ' Hayley Atwell',
      character: 'Captain Carter',
      image: AppAssets.HayleyAtwell,
    ),
    cast(
      name: ' Elizabeth Olsen',
      character: 'Wanda Maximoff / The Scarlet Witch',
      image: AppAssets.ElizabethOlsen,
    ),
    cast(
      name: 'Rachel McAdams',
      character: ' Dr. Christine Palmer',
      image: AppAssets.RachelMcAdams,
    ),
    cast(
      name: ' Charlize Theron',
      character: 'Clea',
      image: AppAssets.CharlizeTheron,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppAssets.doctorStrangeImg,
                ), // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blackColor.withOpacity(0.6),
                    AppColors.blackColor, // Fade to a solid color
                  ],
                  stops: [0.0, 0.5], // Adjust the gradient transition point
                ),
              ),
              child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:size.height*0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() { isBookMarked = !isBookMarked; });
                          },
                          icon: Icon(
                            isBookMarked ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.09),
                  Image.asset(AppAssets.playMovieImage),
                  ///todo:Movie descreption
                  Text(
                    "Doctor Strange in The Multiverse\n of Madness",
                    style: AppStyles.robotoBold24White,
                    textAlign: TextAlign.center,
                  ),

                  ///todo:Movie production Year
                  Text(
                    "2022",
                    style: AppStyles.robotoBold20LightGray,
                    textAlign: TextAlign.center,
                  ),

                  ///todo: Watch Button
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Watch",
                      style: AppStyles.robotoBold20White,
                      textAlign: TextAlign.center,
                    ),
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
                  ),

                  ///todo: Fav Continer , Movie Time Continer , Rating Continer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ratingWidget(text: '15',image: AppAssets.heartIconPng,),
                      ratingWidget(text: '90',image: AppAssets.timerIconPng,),
                      ratingWidget(text: '7.5',image: AppAssets.starIconPng,),
                    ],
                  ),
                  TitleWidget(text: "Screen Shots"),
                  Screenshotswidget(),
                  TitleWidget(text: "Similar"),
                  Similarmoviecarts(cardList: cardList),
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
                  Container(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return
                          Container(
                          padding: EdgeInsets.only(left: size.width*0.02 , bottom:size.height*0.01  ,top: size.height*0.01 ,),
                          decoration: BoxDecoration(
                            color: AppColors.darkGrayColor,
                            borderRadius: BorderRadius.circular(16)
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
                                    RichText(
                                      text: TextSpan(
                                        style: AppStyles.robotoRegular16White
                                            .copyWith(height: 1.5),
                                        children: [
                                          TextSpan(
                                            text:
                                                'Name : ${castMan[index].name.trimRight()}',
                                            style: AppStyles.interRegular16White,
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: AppStyles.robotoRegular16White.copyWith(height: 1.1),
                                        children: [
                                          TextSpan(
                                              text:'Character : ${castMan[index].character.trimRight()}',
                                              style: AppStyles.interRegular16White
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: size.height * 0.02);
                      },
                      itemCount: castMan.length,
                    ),
                  ),
                  TitleWidget(text: 'Genres'),
                Container(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // tabels count
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    return genreswidget(text: 'Action',);
                  },
                  itemCount:5,
                ),),
                  SizedBox(height: size.height*0.005,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
