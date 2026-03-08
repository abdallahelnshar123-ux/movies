import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubit/auth_view_model.dart';
import 'package:movies/utils/app_colors.dart';

import '../../Api/model/inner_classes/movie.dart';
import '../../utils/firebase_utils.dart';

class BookMarkWidget extends StatelessWidget {
  final Movie movie;

  const BookMarkWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var userId = context.watch<AuthCubit>().currentUser?.id;

    if (userId == null) {
      return const SizedBox();
    }

    return StreamBuilder<DocumentSnapshot<Movie>>(
      stream: FirebaseUtils.watchMovieInWatchList(uId: userId, movie: movie),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Icon(
            Icons.bookmark_border_rounded,
            size: 30,
            color: AppColors.whiteColor,
          );
        }

        bool isSaved = snapshot.data?.exists ?? false;

        return IconButton(
          selectedIcon: const Icon(Icons.bookmark_rounded),
          isSelected: isSaved,

          iconSize: 30,
          color: AppColors.whiteColor,
          icon: const Icon(Icons.bookmark_border_rounded),
          onPressed: () async {
            if (isSaved) {
              await FirebaseUtils.deleteMovieFromWatchList(
                movie: movie,
                uId: userId,
              );
              debugPrint('delete');
            } else {
              await FirebaseUtils.addMovieToWatchList(
                movie: movie,
                uId: userId,
              );
              debugPrint('add');
            }
          },
        );
      },
    );
  }
}
