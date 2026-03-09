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
    return ClipRRect(
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
                color: Colors.black.withAlpha(179),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: context.width * 0.015,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(movieRating, style: AppStyles.robotoRegular14White),

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
    );
  }
}
