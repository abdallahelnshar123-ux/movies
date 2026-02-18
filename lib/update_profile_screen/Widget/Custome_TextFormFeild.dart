import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class CustomeTextfeild extends StatelessWidget {
  final TextEditingController textcontroller;
  final Widget prefixIcon;
  final String hint;
  final VoidCallback onTap;
  CustomeTextfeild({
    super.key,
    required this.prefixIcon,
    required this.textcontroller,
    required this.hint,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: textcontroller,
      cursorColor: AppColors.whiteColor,
      style: AppStyles.robotoRegular16White,
      decoration: InputDecoration(
        hoverColor: Colors.white,
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: AppStyles.robotoRegular16White.copyWith(fontSize: 16 , fontWeight: FontWeight.w800),
        fillColor: AppColors.darkGrayColor,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) , borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(),
      ),
    );
  }
}
