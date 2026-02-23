import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/home_screen/tabs/browse_tab/browse_tab.dart';
import 'package:movies/home_screen/tabs/home_tab/home_tab.dart';
import 'package:movies/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:movies/home_screen/tabs/search_tab/search_tab.dart';

class HomeScreen extends StatelessWidget {
  final List<Widget> tabsList = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: BottomNavigationBar(items: [],));
  }
}
