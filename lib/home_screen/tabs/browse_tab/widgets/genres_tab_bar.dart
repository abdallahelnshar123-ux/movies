import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';

class GenresTabBar extends StatelessWidget {
  final bool isSelected;
  final String category;
  final void Function()? onTap;

  const GenresTabBar(
      {super.key, required this.isSelected, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: context.height * 0.01 ,
        padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.1, vertical: 10),
        alignment: AlignmentGeometry.center,
        decoration: BoxDecoration(
          border: BoxBorder.all(
            color: isSelected ?AppColors.transparentColor: AppColors.yellowColor,
            width: 2
          ),
          color: isSelected ? AppColors.yellowColor : AppColors.transparentColor,
          borderRadius: BorderRadiusGeometry.circular(20)
        ),
        child: Text(category,style: isSelected ?AppStyles.interBold20yellow.copyWith(
          color: AppColors.blackColor
        ) :
        AppStyles.interBold20yellow,),
      ),
    );
  }
}
