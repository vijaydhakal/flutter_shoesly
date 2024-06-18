import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';

class BottomSheetWrapper extends StatelessWidget {
  final EdgeInsets? padding;
  final double? topPadding;
  final Widget child;
  final bool showTopDivider;
  final int widgetSpacing;
  const BottomSheetWrapper({
    this.padding,
    this.topPadding,
    this.showTopDivider = true,
    this.widgetSpacing = 24,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Container(
      padding: padding ??
          EdgeInsets.only(
            left: CustomTheme.symmetricHozPadding.wp,
            right: CustomTheme.symmetricHozPadding.wp,
            top: 24.hp,
            bottom: 5.hp,
          ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(36),
        ),
        color: _theme.scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTopDivider)
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: CustomTheme.lightGray,
              ),
            ),
          SizedBox(height: widgetSpacing.hp),
          child,
        ],
      ),
    );
  }
}
