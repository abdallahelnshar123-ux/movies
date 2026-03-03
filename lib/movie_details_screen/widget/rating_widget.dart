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

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.007,
        // horizontal: size.width * 0.06,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.darkGrayColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          // image == null ? const SizedBox() : Image.asset(image!),
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
            softWrap: false, // Allows text to wrap to a second line if needed
          ),
        ],
      ),
    );
  }
}
