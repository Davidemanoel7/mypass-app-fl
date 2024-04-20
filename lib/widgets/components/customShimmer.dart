import 'package:flutter/material.dart';
import 'package:mypass/utils/themes.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.child
  });

  final double width;
  final double height;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyPassColors.whiteF0,
      highlightColor: MyPassColors.whiteF0.withOpacity(0.2),
      child:
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
            width: 1,
            color: MyPassColors.whiteF0.withOpacity(0.2)
            ),
            borderRadius: BorderRadius.circular( borderRadius ),
            gradient: const LinearGradient(
              colors: [
                MyPassColors.whiteF0,
                MyPassColors.greyBD
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd
            )
          ),
          child: child,
        )
    );
  }
}