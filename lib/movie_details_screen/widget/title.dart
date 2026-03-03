import 'package:flutter/material.dart';
import 'package:movies/utils/app_styles.dart';

class TitleWidget extends StatelessWidget {
  String text;
  TitleWidget({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.robotoBold24White,
      textAlign: TextAlign.start,
    );
  }
}
