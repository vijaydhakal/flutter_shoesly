import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double? width;
  final double bottomMargin;
  final double borderRadius;
  final double rightMargin;
  final double leftMargin;

  const ShimmerContainer({
    this.borderRadius = 4,
    this.bottomMargin = 8,
    required this.height,
    required this.width,
    this.rightMargin = 0,
    this.leftMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: bottomMargin, right: rightMargin, left: leftMargin),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: CustomTheme.lightGray.withOpacity(0.2),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
