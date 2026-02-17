import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import '../utils/app_assets.dart';
import '../utils/screen_size.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined ),
        title:  Text("Forget Password" ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: context.height*.04,
          children: [
            Image.asset(AppAssets.forgetPasswordImage),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppColors.whiteColor),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: AppStyles.robotoRegular16White,
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: AppColors.whiteColor,
                ),
                filled: true,
                fillColor: AppColors.darkGrayColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.whiteColor, width: 1),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: context.height*.06,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Verify Email",
                  style:AppStyles.robotoRegular20Black,
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
}
