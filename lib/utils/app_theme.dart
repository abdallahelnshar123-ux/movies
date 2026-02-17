import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.yellowColor,
        ),
        titleTextStyle: AppStyles.robotoRegular16Yellow,
      )

  );
}
