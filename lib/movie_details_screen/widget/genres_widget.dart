import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';

import '../../Api/model/inner_classes/movie.dart';

class GenresWidget extends StatelessWidget {
  final Movie movie;
  final int index;

  const GenresWidget({super.key, required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.height * 0.007),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkGrayColor,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          movie.genres![index],
          style: AppStyles.robotoBold24White,
          textAlign: TextAlign.center,
          softWrap: false,
        ),
      ),
    );
  }
}
