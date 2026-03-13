import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/app_colors.dart';
import 'package:movies/utils/app_styles.dart';

class SectionSwitcher extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const SectionSwitcher({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.03,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkGrayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SectionTab(
                index: 0,
                selectedIndex: selectedIndex,
                iconWidget: SvgPicture.asset(
                  AppAssets.wishlistIcon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                label: 'Watch List',
                onTap: onTabChanged,
              ),
              SectionTab(
                index: 1,
                selectedIndex: selectedIndex,
                iconWidget: SvgPicture.asset(
                  AppAssets.historyIcon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
                label: 'History',
                onTap: onTabChanged,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 2,
                  color: selectedIndex == 0
                      ? AppColors.yellowColor
                      : Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 2,
                  color: selectedIndex == 1
                      ? AppColors.yellowColor
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SectionTab extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final Widget iconWidget;
  final String label;
  final Function(int) onTap;

  const SectionTab({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.iconWidget,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: iconWidget,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppStyles.robotoRegular14White.copyWith(
                  color: isSelected
                      ? AppColors.yellowColor
                      : AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
