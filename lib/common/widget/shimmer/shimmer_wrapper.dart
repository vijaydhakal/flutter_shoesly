
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';

class ShimmerWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double bottomMargin;
  const ShimmerWrapper({
    Key? key,
    required this.child,
    this.padding,
    this.bottomMargin = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: EdgeInsets.only(bottom: bottomMargin.hp),
      color: Colors.transparent,
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        child: child,
        baseColor: CustomTheme.lightGray.withOpacity(0.5),
        highlightColor: Colors.white,
      ),
    );
  }
}
