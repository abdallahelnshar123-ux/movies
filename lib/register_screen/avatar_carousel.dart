import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/providers/avatar_provider.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/screen_size.dart';
import 'package:provider/provider.dart';

class AvatarCarousel extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  final int initialIndex; // اختياري

  const AvatarCarousel({
    super.key,
    this.onChanged,
    this.initialIndex = 0,
  });

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {
  static const int _initialPage = 1000;

  final List<String> avatars = [
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

  late final PageController _controller;

  double _page = _initialPage.toDouble();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialIndex.clamp(0, avatars.length - 1);

    _controller = PageController(
      viewportFraction: 0.35,
      initialPage: _initialPage + selectedIndex, // ✅ يخلي البداية على الافاتار المختار
    );

    _controller.addListener(() {
      setState(() {
        _page = _controller.page ?? _initialPage.toDouble();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged?.call(selectedIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _circularDistance(double a, double b, int n) {
    final d = (a - b).abs();
    return d > n / 2 ? n - d : d;
  }

  @override
  Widget build(BuildContext context) {
    var avatarProvider = Provider.of<AvatarProvider>(context);
    final n = avatars.length;

    return SizedBox(
      height: context.height * 0.180,
      child: PageView.builder(
        controller: _controller,
        itemBuilder: (context, index) {
          final realIndex = index % n;

          final isSelected = avatarProvider.selectedAvatarIndex == realIndex;
          final realPage = _page % n;
          final distance = _circularDistance(realPage, realIndex.toDouble(), n);

          final scale = isSelected
              ? 1.1
              : (1 - (distance * 0.35)).clamp(0.75, 1.05);

          return Center(
            child: Transform.scale(
              scale: scale,
              child: GestureDetector(
                onTap: () {
                  context.read<AvatarProvider>().changeAvatar(realIndex);

                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: context.width * 0.395,
                  height: context.height * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(avatars[realIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}