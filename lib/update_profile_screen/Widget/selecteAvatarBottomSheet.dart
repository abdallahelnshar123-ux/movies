import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:movies/update_profile_screen/model/AvatarData.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';

typedef onAvatarSelected = void Function(int index);

class selecteAvatarbottomsheet extends StatefulWidget {
  final ValueChanged<int> onAvatarSelected;
  int InitialselectedIndex;
  bool checkSelecet = false;

  selecteAvatarbottomsheet({
    super.key,
    required this.onAvatarSelected,
    required this.InitialselectedIndex,
  });

  @override
  State<selecteAvatarbottomsheet> createState() =>
      _selecteAvatarbottomsheetState();
}

class _selecteAvatarbottomsheetState extends State<selecteAvatarbottomsheet> {
  late int selectedIndex;

  void initState() {
    super.initState();
    selectedIndex = widget.InitialselectedIndex;
  }

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
    return Container(
      height: size.height * 0.5,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.015,
        horizontal: size.width * 0.015,
      ),
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.03,
        horizontal: size.width * 0.025,
      ),

      decoration: BoxDecoration(
        color: AppColors.darkGrayColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 15,
            mainAxisExtent: 135,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              widget.checkSelecet = !widget.checkSelecet;
              selectedIndex = index;
              setState(() {});
              widget.onAvatarSelected(index);
              Navigator.pop(context, Duration(seconds: 30));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AvatarList[index].emoji),
                ),
                color: (widget.checkSelecet && selectedIndex == index)
                    ? AppColors.yellowColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.yellowColor, width: 2),
              ),
            ),
          ),
          itemCount: AvatarList.length,
        ),
      ),
    );
  }
}
