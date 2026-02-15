import 'package:flutter/material.dart';
import 'package:movies/forget_password_screen/forget_password_screen.dart';
import 'package:movies/home_screen/home_screen.dart';
import 'package:movies/login_screen/login_screen.dart';
import 'package:movies/onboarding_screen/onboarding_screen.dart';
import 'package:movies/register_screen/register_screen.dart';
import 'package:movies/update_profile_screen/update_profile_screen.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
      },
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
