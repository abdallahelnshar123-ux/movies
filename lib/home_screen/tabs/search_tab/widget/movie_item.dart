import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/screen_size.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movieImage,
    required this.movieRating,
  });

  final String movieImage;
  final String movieRating;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(movieImage, fit: BoxFit.cover),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(movieRating, style: AppStyles.robotoRegular14White),
                    SizedBox(width: context.width * 0.015),
                    SvgPicture.asset(
                      AppAssets.starIcon,
                      height: context.height * 0.016,
                      width: context.width * 0.034,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
