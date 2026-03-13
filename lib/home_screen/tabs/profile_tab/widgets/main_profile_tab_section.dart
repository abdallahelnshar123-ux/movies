import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/Api/model/inner_classes/movie.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/firebase_utils.dart';

import 'profile_button.dart';

class MainProfileTabSection extends StatelessWidget {
  final MyUser? user;
  final VoidCallback onLogout;
  final List<String> avatarAssets = const [
    AppAssets.avatarImage1,
    AppAssets.avatarImage2,
    AppAssets.avatarImage3,
    AppAssets.avatarImage4,
    AppAssets.avatarImage5,
    AppAssets.avatarImage6,
    AppAssets.avatarImage7,
    AppAssets.avatarImage8,
    AppAssets.avatarImage9,
  ];

  const MainProfileTabSection({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final int rawIndex = user?.avatarIndex ?? -1;
    // final int safeIndex = rawIndex.clamp(0, avatarAssets.length - 1);
    final String avatarAsset = rawIndex == -1
        ? AppAssets.fallbackUserImage
        : avatarAssets[rawIndex];

    final String? userId = user?.id;

    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: size.width * 0.11,
                  backgroundColor: AppColors.darkGrayColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(size.width * 0.11),
                    child: Image.asset(
                      avatarAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  user?.name ?? 'Guest',
                  style: AppStyles.robotoRegular14White.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(width: size.width * 0.06),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<QuerySnapshot<Movie>>(
                    stream: userId != null
                        ? FirebaseUtils.getWatchListCollection(userId).snapshots()
                        : const Stream.empty(),
                    builder: (context, snapshot) {
                      final int count = snapshot.data?.docs.length ?? 1;
                      return StatItem(
                        title: 'Wish List',
                        count: count,
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot<Movie>>(
                    stream: userId != null
                        ? FirebaseUtils.getHistoryCollection(userId).snapshots()
                        : const Stream.empty(),
                    builder: (context, snapshot) {
                      final int count = snapshot.data?.docs.length ?? 0;
                      return StatItem(
                        title: 'History',
                        count: count,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Row(
          children: [
            Flexible(
              flex: 5,
              child: ProfileButton(
                label: 'Edit Profile',
                backgroundColor: AppColors.yellowColor,
                textColor: AppColors.blackColor,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.updateProfileRouteName,
                  );
                },
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Flexible(
              flex: 3,
              child: ProfileButton(
                label: 'Exit',
                backgroundColor: AppColors.redColor,
                textColor: AppColors.whiteColor,
                icon: const Icon(Icons.logout, size: 18),
                onTap: onLogout,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String title;
  final int count;

  const StatItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: AppStyles.interRegular16White,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppStyles.robotoRegular16White,
        ),
      ],
    );
  }
}
