import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

import '../utils/app_assets.dart';
import '../utils/screen_size.dart';
import 'auth_service.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final AuthService _authService = AuthService();


  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forget Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: context.height * .04,
            children: [
              Image.asset(AppAssets.forgetPasswordImage),
              TextFormField(
                controller: _emailController,
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
                    borderSide: BorderSide(
                      color: AppColors.whiteColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: context.height * .06,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _authService.sendResetPasswordEmail(_emailController.text);
                      debugPrint("SUCCESS: reset email requested for ${_emailController.text.trim()}");

                      if (!context.mounted) return;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text("Email Sent"),
                            content: const Text(
                              "A password reset link has been sent to your email.\n Please check your inbox or spam.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    on FirebaseAuthException catch (e) {
                      if (!context.mounted) return;
                      showDialog(
                        builder: (_) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.message ?? e.code),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                        context: context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Verify Email",
                    style: AppStyles.robotoRegular20Black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}