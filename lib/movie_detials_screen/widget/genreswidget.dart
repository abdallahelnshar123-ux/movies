import 'package:flutter/material.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class genreswidget extends StatelessWidget {
  String? text;
  String? image;
   genreswidget({super.key ,this.image , this.text });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height*0.007 , horizontal: size.width*0.06),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.darkGrayColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 2,
        children: [
          Expanded(
            child: Text(
              text!,
              style: AppStyles.robotoBold24White,
              textAlign: TextAlign.center,
              softWrap: false // Allows text to wrap to a second line if needed
            ),
          ),
          image == null ? const SizedBox() : Image.asset(image!),

        ],
      ),
    );
  }
}
