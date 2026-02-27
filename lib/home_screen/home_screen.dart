import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movies/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movies/home_screen/tabs/search_tab/search_tab.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/screen_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> tabsList = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: tabsList[selectedTabIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(context.width * 0.008),
        margin: EdgeInsets.all(context.width * 0.02),
        decoration: BoxDecoration(
          color: AppColors.darkGrayColor,
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        width: double.infinity,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.transparentColor,
            highlightColor: AppColors.transparentColor,
          ),
          child: BottomNavigationBar(
            fixedColor: AppColors.transparentColor,
            unselectedLabelStyle: TextStyle(fontSize: 0),
            selectedLabelStyle: TextStyle(fontSize: 0),
            backgroundColor: AppColors.transparentColor,
            onTap: (index) {
              selectedTabIndex = index;
              setState(() {});
            },
            items: [
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbHomeIcon,
                index: 0,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbSearchIcon,
                index: 1,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbExploreIcon,
                index: 2,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbProfileIcon,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String iconName,
    required int index,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: SvgPicture.asset(
        iconName,
        colorFilter: ColorFilter.mode(
          index == selectedTabIndex
              ? AppColors.yellowColor
              : AppColors.whiteColor,
          BlendMode.srcIn,
        ),
        width: 24,
      ),
    );
  }
}
