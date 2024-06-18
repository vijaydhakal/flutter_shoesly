import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoesly/app/theme.dart';

class CustomToast {
  static show(
      {required String message,
      Toast? length,
      Color bgColor = CustomTheme.primaryColor,
      ToastGravity? gravity}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: gravity ?? ToastGravity.BOTTOM,
        backgroundColor: bgColor,
        toastLength: length ?? Toast.LENGTH_SHORT);
  }
   static error(
      {required String message, Toast? length, ToastGravity? gravity}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: gravity ?? ToastGravity.BOTTOM,
        backgroundColor: CustomTheme.errorColor,
        toastLength: length ?? Toast.LENGTH_LONG);
  }

  static success(
      {required String message, Toast? length, ToastGravity? gravity}) {
    Fluttertoast.showToast(
        msg: message,
        gravity: gravity ?? ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        toastLength: length ?? Toast.LENGTH_LONG);
  }
}
