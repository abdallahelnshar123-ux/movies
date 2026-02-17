import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class ChangeLanguageItem extends StatelessWidget {
  bool iseSelected = true;
  ChangeLanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.yellowColor)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  // todo change language to en
                },
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.yellow,
                    child: Image.asset(AppAssets.usaLogo, width: 30)
                )),
            const SizedBox(width: 10),
            InkWell(onTap: () {
              // todo change language to ar
            },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: iseSelected == false ? AppColors
                      .yellowColor : Colors.transparent,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(AppAssets.egyptLogo),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
