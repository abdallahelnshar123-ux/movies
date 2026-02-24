import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
 List<String> moviesList = [
   AppAssets.card1Image,
   AppAssets.card2Image,
   AppAssets.card3Image,
   AppAssets.card4Image,
 ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Image.asset(moviesList[currentIndex],
        fit: BoxFit.cover,
        height: 600,  ),
        BackdropFilter(filter: ImageFilter.blur(
          sigmaX: 7,
          sigmaY: 2
        ),
        child: Container(
          color: Colors.black.withOpacity(0.6),
        ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing:context.height*0.02,
            children: [
              Image.asset(AppAssets.availableNowImage),
              CarouselSlider.builder(
                  itemCount: moviesList.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: context.width*0.01
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage(moviesList[index]),
                              fit: BoxFit.cover)
                      ),
                    );
                  },
                  options: CarouselOptions(
                      height: 400,
                      enlargeCenterPage: true,
                      viewportFraction: 0.7,
                      onPageChanged: (index, reason){
                        setState(() {
                          currentIndex = index ;
                        });
                      }
                  )
              ),
              Image.asset(AppAssets.watchNowImage),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width*0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Action',style: AppStyles.robotoRegular20White,),
                    Row(
                      children: [
                        TextButton(onPressed: (){
                          // todo: Navigator to movieDetailsScreen
                        },
                            child: Text('See More',
                              style: AppStyles.robotoRegular16Yellow,)),
                        Icon(Icons.arrow_forward_outlined,size: 18,
                          color: AppColors.yellowColor,)
                      ],
                    )
                  ],
                ),
              ),
               Container(
                 height: 150,
                 padding: EdgeInsets.only(left: context.width*0.04),
                 child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: AssetImage(moviesList[index]))
                        ),
                        width: 115,
                      );
                    },
                    itemCount: moviesList.length),
               ),
            ],
                  ),
          ),
        ),]
    );
  }
}
