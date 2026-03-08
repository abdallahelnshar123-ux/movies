import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  Color decorationColor;
  Color? borderSideColor;
  Widget child;
  void Function() onPressed;
  CustomElevatedButton({super.key,required this.child,required this.decorationColor,this.borderSideColor,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 0),
            side: BorderSide(
                color: borderSideColor??AppColors.transparentColor
            ),
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
            backgroundColor: decorationColor,
            padding: EdgeInsets.symmetric(vertical: height*0.015)
        ),
        onPressed:onPressed, child:child
    );
  }
}
