import 'package:flutter/material.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';
import '../../utils/app_colors.dart';
typedef OnChanged =void Function(String)?;
typedef OnValidator = String? Function(String?)? ;
class CustomTextFormField extends StatelessWidget {
  Color? borderSideColor;
  Color? fillColor;
  bool? filled;
  String? hintText;
  TextStyle? hintStyle;
  String? labelText;
  TextStyle? labelStyle;
  TextStyle? errorStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  int? maxLines;
  OnChanged onChanged;
  TextEditingController? controller;
  OnValidator validator;
  TextInputType? keyboardType;
  String obscuringCharacter;
  bool obscureText;
  CustomTextFormField({
    super.key,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.fillColor,
    this.filled,
    this.borderSideColor,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.controller,
    this.onChanged,
    this.validator,
    this.obscureText=false,
    this.obscuringCharacter='.',
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller:controller ,
      onChanged:onChanged ,
      validator:validator ,
      obscureText: obscureText,
      obscuringCharacter:obscuringCharacter ,
      keyboardType:  keyboardType,
      style: AppStyles.robotoRegular16White,
      cursorColor: AppColors.yellowColor,
      cursorHeight: context.height*0.04,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        errorMaxLines: 2,
        errorStyle: errorStyle,
        enabledBorder: builtDecorationBorder(
          borderColor: borderSideColor ?? AppColors.transparentColor,
        ),
        focusedBorder: builtDecorationBorder(
          borderColor: borderSideColor ?? AppColors.transparentColor,
        ),
        errorBorder: builtDecorationBorder(borderColor: AppColors.redColor),
        focusedErrorBorder: builtDecorationBorder(
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
