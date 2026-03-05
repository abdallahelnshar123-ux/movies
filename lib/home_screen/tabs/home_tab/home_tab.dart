import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/Api/Api_manager.dart';
import 'package:movies/Api/model/movie_model.dart';
import 'package:movies/cubit/fetch_movies_states.dart';
import 'package:movies/cubit/movies_view_model.dart';
import 'package:movies/home_screen/tabs/home_tab/movie_card.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';
import 'package:movies/utils/dialog_utils.dart';
import 'package:movies/utils/screen_size.dart';

import 'home_ui.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
  final MovieModel movie = MovieModel();
  MoviesCubit cubit = MoviesCubit();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MoviesCubit, IntialMoviesState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is LoadingMoviesState) {
          DialogUtils.showLoading(context: context);
        }

        if (state is SuccessMoviesState || state is ErrorMoviesState) {
          Navigator.of(context, rootNavigator: true).pop(); // dismiss loading
        }

        if (state is ErrorMoviesState) {
          DialogUtils.showMessage(
              message: "Something Wrong",
              context: context,
              posAction: () {
                cubit.getMovies();
              },
              posActionText: "Try Again"
          );

        }
      },
      child: BlocBuilder<MoviesCubit, IntialMoviesState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SuccessMoviesState) {
            return HomeUi(
              movies: state.response!,
              currentIndex: currentIndex,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}