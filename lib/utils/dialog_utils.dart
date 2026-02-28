import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

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
            Text(context.tr('loading'), style: AppStyles.robotoRegular14White),
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
            style: AppStyles.robotoRegular16Yellow,
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
            style: AppStyles.robotoRegular16Yellow,
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
          style: AppStyles.robotoRegular14White,
        ),
        title: Text(context.tr(title), style: AppStyles.robotoRegular16Yellow),
        actions: actions,
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<String?> showPasswordDialog({
    required BuildContext context,
    String title = '',
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    TextEditingController passwordController = TextEditingController();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20),
          title: Text(
            context.tr(title),
            style: AppStyles.robotoRegular16Yellow,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr(message),
                style: AppStyles.robotoRegular14White,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // يرجع null
              },
              child: Text(
                context.tr(cancelText),
                style: AppStyles.robotoRegular16Yellow,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, passwordController.text.trim());
              },
              child: Text(
                context.tr(confirmText),
                style: AppStyles.robotoRegular16Yellow,
              ),
            ),
          ],
        );
      },
    );
  }
}
