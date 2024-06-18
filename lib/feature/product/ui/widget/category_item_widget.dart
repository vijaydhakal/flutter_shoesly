import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    Key? key,
    this.height = 62,
    this.width = 62,
    this.color = CustomTheme.primaryColor,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);
  final double height;
  final double width;
  final Color color;
  final String title;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.symmetricHozPadding,
      ),
      child: InkWell(
          onTap: onTap,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: _theme.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: isSelected
                  ? CustomTheme.textColor
                  : CustomTheme.textColor.withOpacity(.3),
            ),
          )),
    );
  }
}
