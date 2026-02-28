import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/auth_state.dart';
import 'package:movies/cubit/auth_view_model.dart';
import 'package:movies/update_profile_screen/Widget/Custome_Botton.dart';
import 'package:movies/update_profile_screen/Widget/Custome_TextFormFeild.dart';
import 'package:movies/update_profile_screen/Widget/selecteAvatarBottomSheet.dart';
import 'package:movies/update_profile_screen/model/AvatarData.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/dialog_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  int currentAvatarIndex = 0;

  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    List<Avatardata> avatarList = [
      Avatardata(
        emoji: AppAssets.avatarImage1,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage2,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage3,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage4,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage5,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage6,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage7,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage8,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
      Avatardata(
        emoji: AppAssets.avatarImage9,
        color: AppColors.darkGrayColor,
        label: "label",
      ),
    ];

    var size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthUpdateSuccess ||
          current is AuthUpdateError ||
          current is AuthUpdateLoading ||
          current is AuthDeleteError ||
          current is AuthDeleteLoading ||
          current is AuthDeleteSuccess,
      listener: (context, state) {
        debugPrint(state.runtimeType.toString());
        if (state is AuthUpdateSuccess) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'success',
            message: 'Profile updated successfully!',
            posActionText: 'Ok',
            posAction: () {
              Navigator.pop(context);
            },
          );
        }
        if (state is AuthUpdateError) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error!!!',
            message: state.message,
            posActionText: 'Ok',
          );
        }
        if (state is AuthUpdateLoading) {
          DialogUtils.showLoading(context: context);
        }
        if (state is AuthDeleteSuccess) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'success',
            message: 'Account deleted successfully!',
            posActionText: 'Ok',
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.loginRouteName,
                (route) => false,
              );
            },
          );
        }
        if (state is AuthDeleteError) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error!!!',
            message: state.message,
            posActionText: 'Ok',
          );
        }
        if (state is AuthDeleteLoading) {
          DialogUtils.showLoading(context: context);
        }
      },

      builder: (context, state) {
        final authCubit = context.watch<AuthCubit>();
        final user = authCubit.currentUser;

        if (user == null) {
          return Center(child: Text("No user found"));
        }

        if (!_isInitialized) {
          nameController.text = user.name;
          phoneController.text = user.phone;
          currentAvatarIndex = user.avatarIndex;
          _isInitialized = true;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("pick Avatar", style: AppStyles.robotoRegular16Yellow),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: AppColors.yellowColor,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.015),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAvatarBottomSheet();
                      },
                      child: SizedBox(
                        height: size.height * 0.12,
                        child: Image.asset(
                          avatarList[currentAvatarIndex].emoji,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    CustomeTextfeild(
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.whiteColor,
                      ),
                      textcontroller: nameController,
                      hint: "Enter Your Name",
                      validation: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    CustomeTextfeild(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColors.whiteColor,
                      ),
                      textcontroller: phoneController,
                      hint: "Enter Your Phone Number",
                      validation: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter a Phone Number';
                        }
                        final phoneRegex = RegExp(r'^01[0-9]{9}$');
                        if (!phoneRegex.hasMatch(text.trim())) {
                          return 'Enter valid phone number';
                        }

                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.forgetPasswordRouteName);
                          },
                          child: Text(
                            "Reset Password",
                            style: AppStyles.robotoRegular16White.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.32),
                    CustomButton(
                      text: 'Delete Account',
                      style: AppStyles.robotoRegular16White.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.redColor,
                      onPressed: () async {
                        String? password = await DialogUtils.showPasswordDialog(
                          context: context,
                          message: 'Please Enter Password  to delete account',
                          title: 'confirmation !',
                        );

                        if (password != null && password.isNotEmpty) {
                          if (!context.mounted) return;
                          context.read<AuthCubit>().deleteUserAccount(password);
                        }
                      },
                    ),
                    CustomButton(
                      text: 'Update Account',
                      style: AppStyles.robotoRegular16DarkGray.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.yellowColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          DialogUtils.showMessage(
                            context: context,
                            title: 'Update Data',
                            message: 'Are you sure you want to update data?',
                            posActionText: 'yes',
                            negActionText: 'Cancel',
                            posAction: () {
                              context.read<AuthCubit>().updateUserData(
                                name: nameController.text,
                                phone: phoneController.text,
                                avatarIndex: currentAvatarIndex,
                              );
                            },
                          );
                        }
                        debugPrint('updated');
                      },
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showAvatarBottomSheet() {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      builder: (context) => selecteAvatarbottomsheet(
        onAvatarSelected: (index) {
          setState(() {
            currentAvatarIndex = index;
          });
        },
        InitialselectedIndex: currentAvatarIndex,
      ),
    );
  }
}
