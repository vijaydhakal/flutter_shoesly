import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shoesly/common/route/routes.dart';
import 'package:shoesly/common/util/size_utils.dart';
import 'package:shoesly/feature/splash/ui/splash_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.productList);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context: context);
    return SplashWidget();
  }
}
