import 'package:flutter/material.dart';
import 'package:shoesly/app/theme.dart';
import 'package:shoesly/common/bloc/multi_repo_provider_listing.dart';
import 'package:shoesly/common/constant/env.dart';
import 'package:shoesly/common/constant/strings.dart';
import 'package:shoesly/common/navigation/nav.dart';
import 'package:shoesly/common/route/route_generator.dart';
import 'package:shoesly/common/route/routes.dart';
import 'package:shoesly/common/widget/global_error_widget.dart';

class App extends StatefulWidget {
  final Env env;
  App({Key? key, required this.env}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProviderListing(
      env: widget.env,
      child: MaterialApp(
        navigatorKey: NavigationService.navKey,
        builder: (context, Widget? widget) {
          setErrorBuilder(context);
          return widget!;
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: CustomTheme.lightTheme,
        title: Strings.APP_TITLE,
        initialRoute: Routes.root,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
