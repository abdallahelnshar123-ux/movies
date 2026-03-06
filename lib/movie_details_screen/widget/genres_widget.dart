import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class GenresWidget extends StatelessWidget {

  final List<String>genresList;

  const GenresWidget({super.key, required this.genresList });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: genresList.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.darkGrayColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            genre,
            style: AppStyles.robotoRegular16White,
          ),
        );
      }).toList(),
    );
  }
}

/*

GridView.custom(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
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
      },
      itemCount: widget.movie.genres?.length ?? 0, childrenDelegate: null,
    )
 */