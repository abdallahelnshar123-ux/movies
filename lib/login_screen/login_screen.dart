import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/screen_size.dart';
import 'package:movies/widgets/custom_elevated_button.dart';
import 'package:movies/widgets/custom_text_form_field.dart';

import '../utils/app_colors.dart';
import '../utils/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isObscure = true;
  bool iseSelected= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:context.width*0.04, vertical:context.height*0.03),
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: context.height*0.02,
              children: [
                Image.asset(AppAssets.appLogo,height:context.height*0.3,),
                CustomTextFormField(
                  prefixIcon:SvgPicture.asset("assets/icons/email-icon.svg",fit:BoxFit.none),
                  hintText: "email".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                ),
                CustomTextFormField(
                  prefixIcon:SvgPicture.asset("assets/icons/password_icon.svg",fit:BoxFit.none),
                  hintText: "password".tr(),
                  hintStyle: AppStyles.robotoRegular16White,
                  obscureText:isObscure,
                  filled: true,
                  fillColor: AppColors.darkGrayColor,
                  suffixIcon:IconButton(onPressed:(){
                    isObscure = !isObscure;
                    setState(() {

                    });
                  },icon:isObscure?Icon(Icons.visibility_off_rounded,color:AppColors.whiteColor):Icon(Icons.visibility_rounded,color:AppColors.whiteColor) )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(tapTargetSize:MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.only(bottom:context.height*0.02)),
                        onPressed:(){
                          //todo Navigate to Forget Password Screen
                          Navigator.pushReplacementNamed(context, AppRoutes.forgetPasswordRouteName);
                        }, child: Text("forget_password".tr(),  style: AppStyles.robotoRegular14Yellow,)),
                ],),
        
                CustomElevatedButton(decorationColor: AppColors.yellowColor, onPressed: (){
                  //todo login
                }, child:Text("login".tr(),style: AppStyles.robotoRegular20Black,)),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("don't_have_account".tr(),style:AppStyles.robotoRegular14White),
                    TextButton(
                      style: TextButton.styleFrom(tapTargetSize:MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.zero),
                        onPressed:(){
                      //todo Navigate to Register Screen
                          Navigator.pushReplacementNamed(context, AppRoutes.registerRouteName);
                    }, child: Text("create_one".tr(),  style: AppStyles.robotoRegular14Yellow,)),
                  ],
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Divider(color:AppColors.yellowColor,
                      indent: context.width*0.09,
                      endIndent: context.width*0.03,
                      ),
                    ),
                    Text("or".tr(),style: AppStyles.robotoRegular15Yellow),
                    Expanded(
                      child: Divider(color:AppColors.yellowColor,
                      indent: context.width*0.03,
                      endIndent: context.width*0.09,
                      ),
                    ),
                  ],),
        
                CustomElevatedButton(decorationColor: AppColors.yellowColor, onPressed: (){
                  //todo login with google
                }, child:Row(
                  spacing: context.width*0.02,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/google_icon.svg",fit:BoxFit.none),
                    Text("login_with_google".tr(),style: AppStyles.robotoRegular20Black,),
                  ],
                )),
        
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top:context.height*0.02),
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
                         SizedBox(width:context.width*0.02),
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
                )
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
