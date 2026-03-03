import 'package:flutter/material.dart';
import 'package:movies/utils/app_assets.dart';

class Screenshotswidget extends StatelessWidget {
  const Screenshotswidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          child: Image.asset(AppAssets.screenShotOne),
          borderRadius: BorderRadiusGeometry.circular(16),
          clipBehavior: Clip.antiAlias,
        ),
        ClipRRect(
          child: Image.asset(AppAssets.screenShotTwo),
          borderRadius: BorderRadiusGeometry.circular(16),
          clipBehavior: Clip.antiAlias,
        ),
        ClipRRect(
          child: Image.asset(AppAssets.screenShotThree
          ),
          borderRadius: BorderRadiusGeometry.circular(16),
          clipBehavior: Clip.antiAlias,
        ),
      ],
    );
  }
}
