import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../utils/constansts/color_constants.dart';

class FullScreenCircleLoader extends StatelessWidget {
  const FullScreenCircleLoader({
    super.key,
    this.percentage = 0.8,
    this.circleColor = primaryColor,
  });

  final double percentage;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height * percentage,
      child: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: circleColor,
          size: 50,
        ),
      ),
    );
  }
}
