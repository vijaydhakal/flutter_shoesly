import 'package:flutter/material.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/util/size_utils.dart';

AppBar buildAppBar(String title,
    {Color? bgColor,
    bool showBackButton = true,
    List<Widget> actions = const [],
    Color? backIconColor,
    Color? titleColor}) {
  BuildContext _ctx = NavigationService.navKey.currentContext;
  final _txt = Theme.of(_ctx).textTheme;
  return AppBar(
    backgroundColor: bgColor ?? Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: showBackButton == false
        ? Container()
        : InkWell(
            onTap: () {
              Navigator.pop(_ctx);
            },
            child: Icon(
              Icons.arrow_back,
              color: backIconColor ?? Colors.black,
            ),
          ),
    title: Text(
      title,
      style: _txt.headlineMedium!.copyWith(color: titleColor),
      textScaler: TextScaler.linear(SizeUtils.textScaleFactor),
    ),
    actions: actions,
  );
}
