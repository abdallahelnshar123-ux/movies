import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/providers/app_language_provider.dart';
import 'package:provider/provider.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class ChangeLanguageItem extends StatelessWidget {
  bool iseSelected = true;
  ChangeLanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.yellowColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => languageProvider.changeLanguage(context, 'en'),
              child: CircleAvatar(
                radius: 20,
                backgroundColor:  languageProvider.isEnglish()? AppColors.yellowColor : Colors.transparent,
                child: Image.asset(AppAssets.usaLogo, width: 30),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => languageProvider.changeLanguage(context, 'ar'),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: languageProvider.isEnglish()? AppColors.transparentColor : AppColors.yellowColor,
                child: CircleAvatar(
                  radius:14,
                  backgroundImage: AssetImage(AppAssets.egyptLogo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
