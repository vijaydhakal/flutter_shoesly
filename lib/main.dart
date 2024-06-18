import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoesly/app/app.dart';
import 'package:shoesly/common/constant/env.dart';
import 'package:shoesly/common/util/log.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      );

    runApp(
      App(env: EnvValue.development),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
