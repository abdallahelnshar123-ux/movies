import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/cubit/auth_view_model.dart';
import 'package:movies/widgets/change_language_item.dart';

import '../../model/my_user.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_styles.dart';
import '../../utils/screen_size.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late MyUser? user;

  bool isObscure = true;

  String language = 'en';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: context.height * 0.03,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: context.height * 0.02,
              children: [
                Image.asset(AppAssets.appLogo, height: context.height * 0.3),
                CustomTextFormField(
                  validator: (text) {
                    if (text?.trim().isEmpty ?? true) {
                      return context.tr('please_enter_email');
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text!);
                    if (!emailValid) {
                      return context.tr('please_enter_valid_email');
                    }
                    return null;
                  },
                  controller: emailController,
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/email-icon.svg",
                    fit: BoxFit.none,
                  ),
                  hintText: "email".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                CustomTextFormField(
                  validator: (text) {
                    if (text?.trim().isEmpty ?? true) {
                      return context.tr('please_enter_password');
                    }
                    if (text!.length < 6) {
                      return context.tr('password_must_be_at_least');
                    }
                    return null;
                  },
                  controller: passwordController,
                  prefixIcon: SvgPicture.asset(
                    "assets/icons/password_icon.svg",
                    fit: BoxFit.none,
                  ),
                  hintText: "password".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
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
                        : Icon(
                            Icons.visibility_rounded,
                            color: AppColors.whiteColor,
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.only(bottom: context.height * 0.02),
                      ),
                      onPressed: () {
                        //todo Navigate to Forget Password Screen
                        Navigator.pushNamed(
                          context,
                          AppRoutes.forgetPasswordRouteName,
                        );
                      },
                      child: Text(
                        "forget_password".tr(),
                        style: AppStyles.robotoRegular14Yellow,
                      ),
                    ),
                  ],
                ),

                CustomElevatedButton(
                  decorationColor: AppColors.yellowColor,
                  onPressed: () {
                    //todo login
                    if (formKey.currentState?.validate() == true) {
                      context.read<AuthCubit>().loginWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                  child: Text(
                    "login".tr(),
                    style: AppStyles.robotoRegular20Black,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't_have_account".tr(),
                      style: AppStyles.robotoRegular14White,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        //todo Navigate to Register Screen
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.registerRouteName,
                        );
                      },
                      child: Text(
                        "create_one".tr(),
                        style: AppStyles.robotoRegular14Yellow,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowColor,
                        indent: context.width * 0.09,
                        endIndent: context.width * 0.03,
                      ),
                    ),
                    Text("or".tr(), style: AppStyles.robotoRegular15Yellow),
                    Expanded(
                      child: Divider(
                        color: AppColors.yellowColor,
                        indent: context.width * 0.03,
                        endIndent: context.width * 0.09,
                      ),
                    ),
                  ],
                ),

                CustomElevatedButton(
                  decorationColor: AppColors.yellowColor,
                  onPressed: () {
                    //todo login with google

                    context.read<AuthCubit>().loginWithGoogle();
                  },
                  child: Row(
                    spacing: context.width * 0.02,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/google_icon.svg",
                        fit: BoxFit.none,
                      ),
                      Text(
                        "continue_with_google".tr(),
                        style: AppStyles.robotoRegular20Black,
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
}
