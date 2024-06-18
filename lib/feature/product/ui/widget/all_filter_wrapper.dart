import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/util/size_utils.dart';

class AllFilterWrapper extends StatelessWidget {
  final String title;
  final Widget child;
  const AllFilterWrapper({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CustomTheme.symmetricHozPadding,
        vertical: 16,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              // horizontal: CustomTheme.symmetricHozPadding,
              vertical: 4.hp,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: _textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 20.0),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: 4.hp,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
