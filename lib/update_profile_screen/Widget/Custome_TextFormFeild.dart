import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
typedef validator = String? Function(String?);
typedef OnChanged = Function(String?);
class CustomeTextfeild extends StatelessWidget {
  final TextEditingController textcontroller;
  final Widget prefixIcon;
  final String hint;
  final String? initialValue;
  validator? validation;
  OnChanged? onChanged;
  CustomeTextfeild({
    super.key,
    required this.prefixIcon,
    required this.textcontroller,
    required this.hint,
    required this.validation,
    this.initialValue,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validation ,
      initialValue: initialValue,
      controller: textcontroller,
      cursorColor: AppColors.whiteColor,
      style: AppStyles.robotoRegular16White,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hint,
        hintStyle: AppStyles.robotoRegular16White.copyWith(fontSize: 16 , fontWeight: FontWeight.w800),
        fillColor: AppColors.darkGrayColor,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15) , borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: AppColors.redColor , width: 2, )),
        focusedErrorBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: AppColors.redColor , width: 2, )),
        errorStyle: TextStyle(color: Colors.red ,fontSize:10 ),
        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
      ),
    );
  }
  OutlineInputBorder builtDecorationBorder({required borderSideColor}){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
            color:borderSideColor,
            width: 2
        )
    );
  }
}
