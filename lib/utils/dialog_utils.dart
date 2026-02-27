import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';

class DialogUtils {
  static void showLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            CircularProgressIndicator(color: AppColors.yellowColor),
            Text(
              context.tr('loading'),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    String title = '',
    required String message,
    String? posActionText,
    VoidCallback? posAction,
    String? negActionText,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            context.tr(posActionText),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      );
    }
    if (negActionText != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            context.tr(negActionText),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        content: Text(
          context.tr(message),
          style: Theme.of(context).textTheme.displaySmall,
        ),
        title: Text(
          context.tr(title),
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: actions,
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
