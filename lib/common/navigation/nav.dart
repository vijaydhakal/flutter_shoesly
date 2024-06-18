import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  static get navKey => _navKey;

  static BuildContext? _context = _navKey.currentContext;

  static get context => _context;

  static void pushNamed(String routeName) {
    _navKey.currentState!.pushNamed(routeName);
  }

  static void pushReplacementNamed(String routeName) {
    _navKey.currentState!.pushNamed(routeName);
  }

  static Future<T?> push<T extends Object?>(Widget widget,
      {String? routeName}) async {
    return await _navKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: routeName),
      ),
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(Widget route,
      {String? routeName}) async {
    return await _navKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => route,
          settings: RouteSettings(name: routeName),
        ),
        (Route<dynamic> route) => false);
  }

  static Future<T?> pushReplacement<T extends Object?>(Widget widget,
      {String? routeName}) async {
    return await _navKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: routeName),
      ),
    );
  }

  static void popUntilFirst() {
    Navigator.of(_context!).popUntil((route) => route.isFirst);
  }

  static void pop() {
    Navigator.of(_context!).pop();
  }
}
