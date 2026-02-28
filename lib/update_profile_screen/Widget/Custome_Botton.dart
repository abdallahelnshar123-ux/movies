import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  TextStyle style;
  Color backgroundColor;
  VoidCallback onPressed;
  CustomButton({super.key ,required this.text,required this.backgroundColor , required this.style,  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal:size.width*0.32 ,vertical: size.height*0.015),
        backgroundColor: backgroundColor,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
            child: Text(text , style: style, maxLines: 1,)
        )
    );
  }
}
