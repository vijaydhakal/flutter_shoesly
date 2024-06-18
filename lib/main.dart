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
        options: FirebaseOptions(
      apiKey: 'AIzaSyD5S7F5O0TyK2ylTqYmpHQci-Bjvfk9DYk',
      appId: '1:22188474003:android:39a914f4baf4048542d766',
      messagingSenderId: '22188474003',
      projectId: 'shoesly-a39a3',
      storageBucket: "shoesly-a39a3.appspot.com",
    ));

    runApp(
      App(env: EnvValue.development),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
