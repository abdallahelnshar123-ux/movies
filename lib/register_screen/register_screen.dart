import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/register_screen/avatar_carousel.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/dialog_utils.dart';
import 'package:movies/utils/firebase_utils.dart';
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
  int selectedIndexAvatar = 0;

  @override
  Widget build(BuildContext context) {
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
                      AvatarCarousel(
                        onChanged: (index) {
                          selectedIndexAvatar = index;
                        },
                      ),
                      Text(
                        'Avatar'.tr(),
                        style: AppStyles.robotoRegular16White,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.text,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
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
                    if (text == null || text.trim().isEmpty) {
                      return 'please Enter Email';
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text); //or emailController
                    if (!emailValid) {
                      return 'please enter valid email'.tr();
                    }
                    return null;
                  },
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
                  keyboardType: TextInputType.text,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
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
                  keyboardType: TextInputType.text,
                  errorStyle: TextStyle(
                    color: AppColors.redColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
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
                  validator: phoneValidator,
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
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.02,
                  ),
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
                                  Navigator.of(
                                    context,
                                  ).pushNamed(AppRoutes.loginRouteName);
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

  Future<void> register() async {
    if (formKey.currentState?.validate() == true) {
      //todo: register
      //todo: show loading
      DialogUtils.showLoading(context: context);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        //todo: hide loading

        //todo: add user to firebase firestore
        MyUser myUser = MyUser(
          id: credential.user!.uid,
          email: emailController.text,
          name: nameController.text,
          phone: phoneController.text,
          avatarIndex: selectedIndexAvatar,
          provider: AuthProviders.emailPassword,
        );

        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context: context);

        //todo: show message
        DialogUtils.showMessage(
          context: context,
          title: 'success',
          message: 'Register Successfully',
          posActionText: 'ok',
          posAction: () {
            Navigator.of(context).pushNamed(AppRoutes.loginRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context: context);
          //todo: show message
          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            title: 'error',
            posActionText: 'ok',
          );
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context: context);
          //todo: show message
          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            title: 'error',
            posActionText: 'ok',
          );
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context: context);
        //todo: show message
        DialogUtils.showMessage(
          context: context,
          message: '$e',
          title: 'error',
          posActionText: 'ok',
        );
      }
    }
  }

  String? phoneValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'please enter phone number';
    }
    final phone = text.trim();
    final basic = RegExp(r'^01[0-9]{9}$');
    if (!basic.hasMatch(phone)) {
      return 'Enter a valid phone number e.g.(0123456789)';
    }

    return null;
  }
}
