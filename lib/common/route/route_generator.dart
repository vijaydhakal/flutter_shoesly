import 'package:flutter/material.dart';
import 'package:shoesly/common/route/routes.dart';
import 'package:shoesly/feature/product/ui/screen/product_list_page.dart';
import 'package:shoesly/feature/splash/ui/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case Routes.productList:
        return MaterialPageRoute(builder: (_) => ProductListPageScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }
}
