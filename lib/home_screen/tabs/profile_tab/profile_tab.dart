import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Api/model/inner_classes/movie.dart';
import 'package:movies/cubit/auth_view_model.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/firebase_utils.dart';
import 'package:movies/utils/screen_size.dart';

import 'widgets/main_profile_tab_section.dart';
import 'widgets/movie_grid.dart';
import 'widgets/section_switcher.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final MyUser? user = context
        .watch<AuthCubit>()
        .currentUser;
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            constraints: BoxConstraints(
              minHeight: context.height * 0.30,
            ),
            padding: EdgeInsets.only(
              top: context.height * 0.02,
              left: context.width * 0.04,
              right: context.width * 0.04,
            ),
            decoration: BoxDecoration(
              color: AppColors.darkGrayColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: size.height * 0.05),
                MainProfileTabSection(
                  user: user,
                  onLogout: () => _handleLogout(context),
                ),
                SectionSwitcher(
                  selectedIndex: selectedSectionIndex,
                  onTabChanged: (index) {
                    setState(() {
                      selectedSectionIndex = index;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildSectionContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context) {
    final String? userId = context.read<AuthCubit>().currentUser?.id;

    if (userId == null) {
      return Center(
        child: Text(
          'can not find user ',
          style: AppStyles.robotoRegular14White,
        ),
      );
    }

    final Stream<QuerySnapshot<Movie>> stream = selectedSectionIndex == 0
        ? FirebaseUtils.getWatchListCollection(userId).snapshots()
        : FirebaseUtils.getHistoryCollection(userId).snapshots();

    return StreamBuilder<QuerySnapshot<Movie>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: AppStyles.robotoRegular14White,
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: context.height * 0.1),
                Image.asset(
                  AppAssets.emptyListImage,
                  width: context.width * 0.26,
                ),
              ],
            ),
          );
        }

        final movies = docs.map((d) => d.data()).toList();
        return MovieGrid(movies: movies);
      },
    );
  }

  void _handleLogout(BuildContext context) {
    context.read<AuthCubit>().logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginRouteName,
      (route) => false,
    );
  }
}
