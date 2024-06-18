import 'package:flutter/material.dart';
import 'package:shoesly/common/constant/constant_assets.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/common/widget/page_wrapper.dart';

class SplashWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: Container(
        child: Center(
          child: Image.asset(
            Assets.logoBlack,
            height: 80.w,
            width: 80.w,
          ),
        ),
      ),
    );
  }
}
