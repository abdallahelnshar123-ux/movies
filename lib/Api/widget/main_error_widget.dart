import 'package:flutter/material.dart';

import '../../../api/api_manager.dart';
import '../../utils/app_styles.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage ;
  final VoidCallback onPressed ;
  const MainErrorWidget({super.key,required this.errorMessage,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(errorMessage,
          style: Theme
              .of(context)
              .textTheme
              .labelMedium,),
        ElevatedButton(onPressed:onPressed,
            child: Text('Try Again',
              style: AppStyles.interSBold20Black,))
      ],
    );
  }
}
