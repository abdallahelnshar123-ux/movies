import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/register_screen/avatar_carousel.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passIsObscure = true;
  bool confPassIsObscure = true;
  bool iseSelected = true;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title: Text('Register'.tr(), style: AppStyles.robotoRegular16Yellow),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
          child: Form(
            key: formKey,
            child: Column(
              spacing: context.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * 0.02),
                  child: Column(
                    children: [
                      AvatarCarousel(),
                      Text(
                        'Avatar'.tr(),
                        style: AppStyles.robotoRegular16White,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                 keyboardType:TextInputType.text,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: nameController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please Enter your name'.tr();
                    }
                    return null;
                  },
                  prefixIcon: SvgPicture.asset(
                    AppAssets.nameIcon,
                    fit: BoxFit.none,
                  ),
                  hintText: "Name".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: emailController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please Enter Email';
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text); //or emailController
                    if (!emailValid) {
                      return 'please enter valid email'.tr();
                    }
                    return null;
                  } ,
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/email-icon.svg",
                    fit: BoxFit.none,
                  ),
                  hintText: "Email".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please Enter password'.tr();
                    }
                    if (text.length < 6) {
                      return 'Password should be at least 6 char'.tr();
                    }

                    return null;
                  },
                  controller: passwordController,
                  hintStyle: AppStyles.robotoRegular16White,
                  hintText: "Password".tr(),
                  prefixIcon: SvgPicture.asset(
                    AppAssets.passwordIcon,
                    fit: BoxFit.none,
                  ),
                  obscureText: passIsObscure,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      passIsObscure = !passIsObscure;
                      setState(() {});
                    },
                    icon: passIsObscure
                        ? Icon(
                            Icons.visibility_off_rounded,
                            color: AppColors.whiteColor,
                          )
                        : Icon(
                            Icons.visibility_rounded,
                            color: AppColors.whiteColor,
                          ),
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please Enter Re-Password'.tr();
                    }
                    if (text != passwordController.text) {
                      return "Re-password doesn't match password".tr();
                    }
                    return null;
                  },
                  controller: confPasswordController,
                  hintText: "Confirm Password".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.passwordIcon,
                    fit: BoxFit.none,
                  ),
                  obscureText: confPassIsObscure,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                  suffixIcon: IconButton(
                    onPressed: () {
                      confPassIsObscure = !confPassIsObscure;
                      setState(() {});
                    },
                    icon: confPassIsObscure
                        ? Icon(
                            Icons.visibility_off_rounded,
                            color: AppColors.whiteColor,
                          )
                        : Icon(
                            Icons.visibility_rounded,
                            color: AppColors.whiteColor,
                          ),
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.phone,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: phoneController,
                  validator:(text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'please Enter your phone number'.tr();
                    }

                    return null;
                  } ,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.phoneIcon,
                    fit: BoxFit.none,
                  ),
                  hintText: "Phone Number".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height * 0.02),
                  child: Column(
                    spacing: context.height * 0.02,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomElevatedButton(
                        decorationColor: AppColors.yellowColor,
                        onPressed: register,
                        child: Text(
                          'Create Account'.tr(),
                          style: AppStyles.robotoRegular20Black,
                        ),
                      ),

                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: "Already Have Account? ".tr(),
                          style: AppStyles.robotoRegular14White,
                          children: [
                            TextSpan(
                              text: "Login".tr(),
                              style: AppStyles.robotoRegular14Yellow,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                Navigator.of(context).pushNamed(AppRoutes.loginRouteName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                ChangeLanguageItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
   void register(){
    if(formKey.currentState?.validate() == true){
      //todo: register
    }
   }
}
