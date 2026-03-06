import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/login_screen/widget/Login_ui.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/dialog_utils.dart';

import '../cubit/auth_state.dart';
import '../cubit/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  // bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            title: 'success',
            context: context,
            message: 'login_successfully',
          );
          Future.delayed(
            Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.homeRouteName,
              // AppRoutes.homeRouteName,
              (route) => false,
            ),
          );
        }

        if (state is AuthLoginError) {
          debugPrint(state.message);
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: 'ok',
            title: 'error',
            context: context,
            message: state.message,
          );
        }
        if (state is AuthLoginLoading) {
          DialogUtils.showLoading(context: context);
        }
      },
      child: LoginUi(),
    );
  }
}
