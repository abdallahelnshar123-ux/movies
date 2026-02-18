import 'package:flutter/material.dart';
import 'package:movies/update_profile_screen/Widget/Custome_Botton.dart';
import 'package:movies/update_profile_screen/Widget/Custome_TextFormFeild.dart';
import 'package:movies/update_profile_screen/Widget/selecteAvatarBottomSheet.dart';
import 'package:movies/update_profile_screen/model/AvatarData.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  UpdateProfileScreen({super.key});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int currentAvatarIndex = 0;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Avatardata> AvatarList = [
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
    return Scaffold(
      appBar: AppBar(
        title: Text("pick Avatar", style: AppStyles.robotoRegular16Yellow),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, size: 25, color: AppColors.yellowColor),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:size.width*0.015),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              GestureDetector(
                onTap: () {
                  showAvatrBottomSheet();
                },
                child:SizedBox(
                  height: size.height*0.12,
                  child:Image.asset(AvatarList[currentAvatarIndex].emoji , fit: BoxFit.cover,),
                )
              ),
              SizedBox(height: size.height*0.01,),
              CustomeTextfeild(
                prefixIcon: Icon(Icons.person, color: AppColors.whiteColor),
                textcontroller: namecontroller,
                hint: "Enter Your Name",
                onTap: () {},
              ),
              CustomeTextfeild(
                prefixIcon: Icon(Icons.phone, color: AppColors.whiteColor),
                textcontroller: phonecontroller,
                hint: "Enter Your Phone Number",
                onTap: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.forgetPasswordRouteName);
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
              ),
              CustomButton(
          
                text: 'Update Account',
                style: AppStyles.robotoRegular16DarkGray.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: AppColors.yellowColor,
              ),
              SizedBox(height: size.height * 0.015),
            ],
          ),
        ),
      ),
    );
  }

  void showAvatrBottomSheet() {
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
