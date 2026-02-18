import 'package:flutter/material.dart';
import 'package:movies/onboarding_screen/CustomButton.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';
import '../utils/app_assets.dart';
import '../utils/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
   OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
   final PageController controller =  PageController();
  int currentIndex = 0;

   final List<Color> gradientColors = [
     AppColors.blackGradientTop,
     AppColors.cyanGradiantColor,
     AppColors.orangeGradiantColor,
     AppColors.purpleGradiantColor,
     AppColors.redGradiantColor,
     AppColors.blackGradiantColor,
   ];

  @override
  void initState() {
    controller.addListener(() {
      currentIndex = controller.page!.toInt();
    },);
    setState(() {

    });
    super.initState();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> pages = [
    {
      "image": AppAssets.onBoardingImage1,
      "title": "Find Your Next Favorite Movie Here",
      "subtitle":
      "Get access to a huge library of movies to suit all tastes. You will surely like it.",
    },
    {
      "image": AppAssets.onBoardingImage2,
      "title": "Discover Movies",
      "subtitle":
      "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
    },
    {
      "image": AppAssets.onBoardingImage3,
      "title": "Explore All Genres",
      "subtitle":
      "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
    },
    {
      "image": AppAssets.onBoardingImage4,
      "title": "Create Watchlists",
      "subtitle":
      "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
    },
    {
      "image": AppAssets.onBoardingImage5,
      "title": "Rate, Review, and Learn",
      "subtitle":
      "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    },
    {
      "image": AppAssets.onBoardingImage6,
      "title": "Start Watching Now",
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      controller.nextPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      controller.previousPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void finishOnboarding() {
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.loginRouteName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          currentIndex = index;
          setState(() {

          });
        },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    pages[index]["image"],
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.transparentColor,
                          gradientColors[index],
                        ],
                        stops:[0, 1.0],
                      ),
                    ),
                  ),
                ),

                //todo : first page only
                index == 0 ?
                  Padding(
                    padding:
                     EdgeInsets.symmetric(horizontal: context.width * 0.01,
                         vertical:context.height * 0.05 ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         Text(
                           pages[index]["title"]!,
                          style: AppStyles.interMedium36White,
                           textAlign: TextAlign.center,
                        ),
                         SizedBox(height: context.height * 0.01),
                         Text(
                           pages[index]["subtitle"]!,
                          style: AppStyles.interRegular20White,
                           textAlign: TextAlign.center,
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomButtonWidget(
                          text: "Explore Now",
                          onPressed: nextPage,
                        ),
                      ],
                    ),
                  )
                : //todo : other pages
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: context.width,
                      padding:  EdgeInsets.symmetric(
                          horizontal: context.width * 0.06,
                          vertical:  context.height * 0.04),
                      decoration:  BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)
                        )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pages[index]["title"],
                            textAlign: TextAlign.center,
                            style: AppStyles.interBold24white
                          ),
                          SizedBox(height: context.height * 0.02),
                          pages[index]["subtitle"] != null ? Text(
                            pages[index]["subtitle"],
                            textAlign: TextAlign.center,
                            style: AppStyles.interRegular20White
                          ):SizedBox(),
                          SizedBox(height: context.height * 0.02),

                          if (index == pages.length - 1)
                            Column(
                              children: [
                                CustomButtonWidget(
                                  text: "Finish",
                                  onPressed: finishOnboarding,
                                ),
                                SizedBox(height: context.height * 0.01),
                                CustomButtonWidget(
                                  text: "Back",
                                  isOutlined: true,
                                  onPressed: previousPage,
                                ),
                              ],
                            )
                          else if (index == 1)
                            CustomButtonWidget(
                              text: "Next",
                              onPressed: nextPage,
                            )
                          else
                            Column(
                              children: [
                                CustomButtonWidget(
                                  text: "Next",
                                  onPressed: nextPage,
                                ),
                                 SizedBox(height: 12),
                                CustomButtonWidget(
                                  text: "Back",
                                  isOutlined: true,
                                  onPressed: previousPage,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          }
      ),
    );
  }
}
