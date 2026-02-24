import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.blackColor
  ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent
    )
  );

}
