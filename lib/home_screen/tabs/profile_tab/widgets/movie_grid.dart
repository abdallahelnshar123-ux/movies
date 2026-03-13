import 'package:flutter/material.dart';
import 'package:movies/Api/model/inner_classes/movie.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_routes.dart';
import 'package:movies/utils/app_styles.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieGridItem(movie: movies[index]);
      },
    );
  }
}

class MovieGridItem extends StatelessWidget {
  final Movie movie;

  const MovieGridItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.movieDetailsScreen,
          arguments: movie.id,
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network(
                movie.mediumCoverImage ?? movie.largeCoverImage ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.darkGrayColor,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.blackColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${movie.rating ?? 0}',
                    style: AppStyles.robotoRegular14White.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
