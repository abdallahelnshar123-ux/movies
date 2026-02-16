import 'package:flutter/cupertino.dart';
import 'package:movies/utils/app_assets.dart';
import 'package:movies/utils/screen_size.dart';

class AvatarCarousel extends StatefulWidget {
  const AvatarCarousel({super.key});

  @override
  State<AvatarCarousel> createState() => _AvatarCarouselState();
}

class _AvatarCarouselState extends State<AvatarCarousel> {

  final PageController _controller = PageController(viewportFraction: 0.35,initialPage: 1);

  double _page = 0;

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

  @override
  void initState(){
    super.initState();
  _controller.addListener((){
    setState(() {
      _page=_controller.page??0;
    });
  });
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();

    return SizedBox(
      height: 150,
      child: PageView.builder(

          controller: _controller,
          itemCount: avatars.length,
          itemBuilder:(context, index) {
            final distance = (_page - index).abs();
            final scale = (1 - (distance * 0.35)).clamp(0.75, 1.15);

            return Center(
              child: Transform.scale(
                scale: scale,
                child: GestureDetector(
                  onTap: (){
                    _controller.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: context.width*0.395,
                      height: context.height*0.14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(avatars[index]), fit: BoxFit.cover)
                      ),
                    ),
                  ),
                ),
              ),
            );


          }, ),
    );
  }
}
