

import 'package:flutter/material.dart';
import 'package:shoesly/common/constant/constant_assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key, this.message}) : super(key: key);
  final String? message; 

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logoColor,
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              message?? "No data found",
              style: _theme.textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
