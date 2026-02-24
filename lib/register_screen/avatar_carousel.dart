import 'package:flutter/cupertino.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/screen_size.dart';

class AvatarCarousel extends StatefulWidget {
  const AvatarCarousel({super.key});

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  // todo: Start from a large page index to allow infinite scrolling left/right
  static const int _initialPage = 1000;

  String? selectedAvatar;

  final List<String> avatars = [
    AppAssets.avatarImage1,
    AppAssets.avatarImage2,
    AppAssets.avatarImage3,
    AppAssets.avatarImage4,
    AppAssets.avatarImage5,
    AppAssets.avatarImage6,
    AppAssets.avatarImage7,
    AppAssets.avatarImage8,
    AppAssets.avatarImage9,
  ];

  late final PageController _controller;

  double _page = _initialPage.toDouble();

  @override
  void initState() {
    super.initState();

    // todo: Initialize controller with viewportFraction and a big initialPage.
    _controller = PageController(
      viewportFraction: 0.35,
      initialPage: _initialPage,
    );

    _controller.addListener(() {
      setState(() {
        _page = _controller.page ?? _initialPage.toDouble();
      });
    });
  }

  @override
  void dispose() {
    // todo: Always dispose controllers to prevent memory leaks.
    _controller.dispose();
    super.dispose();
  }


  // todo: Circular distance so scaling stays smooth when wrapping from last -> first.
  //          Example: distance between 0 and 8 in a list of 9 should be 1 (wrap-around),
  //          not 8.
  double _circularDistance(double a, double b, int n) {
    final d = (a - b).abs();    /// 8 - 1 = -7  = 7
    return d > n / 2 ? n - d : d;
  }

  @override
  Widget build(BuildContext context) {
    final n = avatars.length;

    return SizedBox(
      height:context.height*0.180 ,
      child: PageView.builder(
        controller: _controller,

        itemBuilder: (context, index) {
          final realIndex = index % n;
          final isSelected = selectedAvatar == avatars[realIndex];

          final realPage = _page % n;

          final distance = _circularDistance(realPage, realIndex.toDouble(), n);

          final scale = isSelected
              ? 1.1
              : (1 - (distance * 0.35)).clamp(0.75, 1.05); //0.8

          return Center(
            child: Transform.scale(
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[realIndex];
                  });


                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(

                  width: context.width * 0.395,
                  height: context.height * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    image: DecorationImage(
                      image: AssetImage(avatars[realIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
