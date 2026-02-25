import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/app_styles.dart';

import 'app_colors.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String loadingMessage,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.blackColor,
          content: Row(
            spacing: 20,
            children: [
              CircularProgressIndicator(color: AppColors.yellowColor),
              Text(
                loadingMessage,
                style: AppStyles.robotoRegular16Yellow,
              ).tr(),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
  })
  {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction!=null){
            //   posAction.call();
            // }
            posAction?.call();
          },
          child: Text(
            posActionName,
            style:AppStyles.robotoRegular16Yellow,
          ).tr(),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // if(posAction!=null){
            //   posAction.call();
            // }
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: AppStyles.robotoRegular16Yellow,
          ).tr(),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.blackColor,
          content: Text(
            message,
            style:AppStyles.robotoRegular16Yellow ,
          ).tr(),
          title: title == null ? null : Text(title, style: AppStyles.robotoRegular16Yellow,).tr(),
          actions: actions,
        );
      },
    );
  }
}
