import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final double? rating;
  final double width;
  final double height;
  final TextStyle ratingTextStyle;
  final double starSize;
  final EdgeInsets badgePadding;
  final EdgeInsets margin;
  final double borderRadius;
  final Color badgeColor;
  final double badgeTop;
  final double badgeLeft;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.rating,
    required this.ratingTextStyle,
    this.starSize = 16,
    this.badgePadding =
    const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    this.margin = EdgeInsets.zero,
    this.borderRadius = 20,
    this.badgeColor = const Color(0xB3000000),
    this.badgeTop = 6,
    this.badgeLeft = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Positioned(
          top: badgeTop,
          left: badgeLeft,
          child: Container(
            padding: badgePadding,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rating != null
                      ? rating!.toStringAsFixed(1)
                      : "unrated",
                  style: ratingTextStyle,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: starSize,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}