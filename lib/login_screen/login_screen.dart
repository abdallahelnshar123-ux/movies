import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/login_screen/widget/Login_ui.dart';
import 'package:movies/utils/app_routes.dart';

import '../cubit/auth_state.dart';
import '../cubit/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return LoginUi();
      },
    );

    //   Scaffold(
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal:context.width*0.04, vertical:context.height*0.03),
    //       child: Form(
    //         key: formState,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           spacing: context.height*0.02,
    //           children: [
    //             Image.asset(AppAssets.appLogo,height:context.height*0.3,),
    //             CustomTextFormField(
    //               prefixIcon:SvgPicture.asset("assets/icons/email-icon.svg",fit:BoxFit.none),
    //               hintText: "email".tr(),
    //               hintStyle: AppStyles.robotoRegular16White,
    //               filled: true,
    //               fillColor: AppColors.darkGrayColor,
    //             ),
    //             CustomTextFormField(
    //               prefixIcon:SvgPicture.asset("assets/icons/password_icon.svg",fit:BoxFit.none),
    //               hintText: "password".tr(),
    //               hintStyle: AppStyles.robotoRegular16White,
    //               obscureText:isObscure,
    //               filled: true,
    //               fillColor: AppColors.darkGrayColor,
    //               suffixIcon:IconButton(onPressed:(){
    //                 isObscure = !isObscure;
    //                 setState(() {
    //
    //                 });
    //               },icon:isObscure?Icon(Icons.visibility_off_rounded,color:AppColors.whiteColor):Icon(Icons.visibility_rounded,color:AppColors.whiteColor) )
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 TextButton(
    //                     style: TextButton.styleFrom(tapTargetSize:MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.only(bottom:context.height*0.02)),
    //                     onPressed:(){
    //                       //todo Navigate to Forget Password Screen
    //                       Navigator.pushNamed(
    //                           context, AppRoutes.forgetPasswordRouteName);
    //                     }, child: Text("forget_password".tr(),  style: AppStyles.robotoRegular14Yellow,)),
    //             ],),
    //
    //             CustomElevatedButton(decorationColor: AppColors.yellowColor, onPressed: (){
    //               //todo login
    //             }, child:Text("login".tr(),style: AppStyles.robotoRegular20Black,)),
    //
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text("don't_have_account".tr(),style:AppStyles.robotoRegular14White),
    //                 TextButton(
    //                   style: TextButton.styleFrom(tapTargetSize:MaterialTapTargetSize.shrinkWrap,padding: EdgeInsets.zero),
    //                     onPressed:(){
    //                   //todo Navigate to Register Screen
    //                       Navigator.pushReplacementNamed(context, AppRoutes.registerRouteName);
    //                 }, child: Text("create_one".tr(),  style: AppStyles.robotoRegular14Yellow,)),
    //               ],
    //             ),
    //
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Expanded(
    //                   child: Divider(color:AppColors.yellowColor,
    //                   indent: context.width*0.09,
    //                   endIndent: context.width*0.03,
    //                   ),
    //                 ),
    //                 Text("or".tr(),style: AppStyles.robotoRegular15Yellow),
    //                 Expanded(
    //                   child: Divider(color:AppColors.yellowColor,
    //                   indent: context.width*0.03,
    //                   endIndent: context.width*0.09,
    //                   ),
    //                 ),
    //               ],),
    //
    //             CustomElevatedButton(decorationColor: AppColors.yellowColor, onPressed: (){
    //               //todo login with google
    //             }, child:Row(
    //               spacing: context.width*0.02,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset("assets/icons/google_icon.svg",fit:BoxFit.none),
    //                 Text("login_with_google".tr(),style: AppStyles.robotoRegular20Black,),
    //               ],
    //             )),
    //
    //             Center(
    //               child: Container(
    //                 margin: EdgeInsets.only(top:context.height*0.02),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(30),
    //                     border: Border.all(color: AppColors.yellowColor)
    //                 ),
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     InkWell(
    //                         onTap: () {
    //                           // todo change language to en
    //                         },
    //                         child: CircleAvatar(
    //                             radius: 20,
    //                             backgroundColor: Colors.yellow,
    //                             child: Image.asset(AppAssets.usaLogo, width: 30)
    //                         )),
    //                      SizedBox(width:context.width*0.02),
    //                     InkWell(onTap: () {
    //                       // todo change language to ar
    //                     },
    //                         child: CircleAvatar(
    //                           radius: 20,
    //                           backgroundColor: iseSelected == false ? AppColors
    //                               .yellowColor : Colors.transparent,
    //                           child: CircleAvatar(
    //                             radius: 14,
    //                             backgroundImage: AssetImage(AppAssets.egyptLogo),
    //                           ),
    //                         )),
    //                   ],
    //                 ),
    //               ),
    //             )
    //
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
