import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/forget_password_screen/forget_password_screen.dart';
import 'package:movies/home_screen/home_screen.dart';
import 'package:movies/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/login_screen/login_screen.dart';
import 'package:movies/onboarding_screen/onBoardingSharedPrefrance.dart';
import 'package:movies/onboarding_screen/onboarding_screen.dart';
import 'package:movies/register_screen/register_screen.dart';
import 'package:movies/update_profile_screen/update_profile_screen.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_theme.dart';

bool isSeen = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  isSeen = await MyPreferences.isOnboardingCompleted();
  runApp(
  EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // initialRoute: isSeen ? AppRoutes.loginRouteName : AppRoutes.onboardingRouteName,
      initialRoute: AppRoutes.homeTabRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfileScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
        AppRoutes.homeTabRouteName: (context) => HomeTab(),
      },
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
