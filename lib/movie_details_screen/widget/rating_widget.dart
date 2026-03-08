import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class ratingWidget extends StatelessWidget {
  String? text;
  String icon;

  ratingWidget({super.key, required this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkGrayColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                AppColors.yellowColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              text!,
              style: AppStyles.robotoBold20White,
              textAlign: TextAlign.center,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}
