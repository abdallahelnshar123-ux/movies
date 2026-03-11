import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class GenresTabBar extends StatelessWidget {
  final bool isSelected;
  final String category;
  final void Function()? onTap;

  const GenresTabBar({
    super.key,
    required this.isSelected,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: isSelected
                ? AppColors.transparentColor
                : AppColors.yellowColor,
            width: 2,
          ),
          color: isSelected
              ? AppColors.yellowColor
              : AppColors.transparentColor,
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Text(
          category,
          style: isSelected
              ? AppStyles.interBold20yellow.copyWith(
                  color: AppColors.blackColor,
                )
              : AppStyles.interBold20yellow,
        ),
      ),
    );
  }
}
