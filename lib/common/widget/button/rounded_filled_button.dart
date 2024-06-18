import 'package:flutter/material.dart';
import 'package:shoesly/common/util/size_utils.dart';

class RoundedFilledButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;
  final double? verticalPadding;
  final bool isLoading;
  final Widget? child;
  final double? horizontalPadding;

  RoundedFilledButton(
      {required this.title,
      required this.onPressed,
      this.backgroundColor,
      this.borderColor,
      this.textColor,
      this.fontSize,
      this.verticalPadding,
      this.isLoading = false,
      this.horizontalPadding,
      this.child});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (!isLoading) {
            onPressed();
          }
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: (verticalPadding ?? 14).hp, horizontal: horizontalPadding??20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor ?? _theme.primaryColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: borderColor ?? Colors.transparent,
              )),
          child: child ??
              Text(
                title,
                textScaler: TextScaler.linear(SizeUtils.textScaleFactor),
                style: _textTheme.labelLarge!.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
    );
  }
}
