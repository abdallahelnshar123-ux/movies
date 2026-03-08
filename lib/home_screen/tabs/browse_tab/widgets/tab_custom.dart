import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';

class TabCustom extends StatelessWidget {
  bool isSelected;
  String category;
  void Function()? onTap;
  TabCustom({super.key,required this.isSelected,required this.category,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: context.height * 0.01 ,
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
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
