import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/register_screen/avatar_carousel.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';
import 'package:movies/widgets/change_language_item.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;
  bool iseSelected = true;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.yellowColor),
        ),
        title: Text('Register', style: AppStyles.robotoRegular16Yellow),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:context.width*0.04),
          child: Column(
            spacing: context.height*0.02,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AvatarCarousel(),
              Text('Avatar', style: AppStyles.robotoRegular16White, textAlign:TextAlign.center,),
              CustomTextFormField(
                prefixIcon: SvgPicture.asset(AppAssets.nameIcon, fit: BoxFit.none),
                hintText: "Name",
                hintStyle: AppStyles.robotoRegular16White,
                filled: true,
                fillColor: AppColors.darkGrayColor,
              ),
              CustomTextFormField(
                prefixIcon: SvgPicture.asset(
                  "assets/icons/email-icon.svg",
                  fit: BoxFit.none,
                ),
                hintText: "Email",
                hintStyle: AppStyles.robotoRegular16White,
                filled: true,
                fillColor: AppColors.darkGrayColor,
              ),
              CustomTextFormField(
                hintStyle: AppStyles.robotoRegular16White,
                hintText: "Password",
                prefixIcon: SvgPicture.asset(
                  AppAssets.passwordIcon,
                  fit: BoxFit.none,
                ),
                obscureText: isObscure,
                filled: true,
                fillColor: AppColors.darkGrayColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: isObscure
                      ? Icon(
                          Icons.visibility_off_rounded,
                          color: AppColors.whiteColor,
                        )
                      : Icon(Icons.visibility_rounded, color: AppColors.whiteColor),
                ),
              ),
              CustomTextFormField(
                hintText: "Confirm Password",
                hintStyle: AppStyles.robotoRegular16White,
                prefixIcon: SvgPicture.asset(
                  AppAssets.passwordIcon,
                  fit: BoxFit.none,
                ),
                obscureText: isObscure,
                filled: true,
                fillColor: AppColors.darkGrayColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                  icon: isObscure
                      ? Icon(
                          Icons.visibility_off_rounded,
                          color: AppColors.whiteColor,
                        )
                      : Icon(Icons.visibility_rounded, color: AppColors.whiteColor),
                ),
              ),
              CustomTextFormField(
                prefixIcon: SvgPicture.asset(AppAssets.phoneIcon, fit: BoxFit.none),
                hintText: "Phone Number",
                hintStyle: AppStyles.robotoRegular16White,
                filled: true,
                fillColor: AppColors.darkGrayColor,
              ),
              CustomElevatedButton(
                  decorationColor: AppColors.yellowColor, onPressed: (){},
                child: Text('Create Account',style: AppStyles.robotoRegular20Black,),
                 ),
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      text: "Already Have Account ?",
                      style: AppStyles.robotoRegular14White,
                      children: [
                        TextSpan(
                          text: "Login",
                          style: AppStyles.robotoRegular14Yellow,)
                      ]
                  )
              ),
              ChangeLanguageItem()
            ],
          ),
        ),
      ),
    );
  }
}
