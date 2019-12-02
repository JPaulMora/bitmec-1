import 'package:flutter/material.dart';

import 'my_routes.dart';
import 'my_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bitmec',
      theme: MyTheme.light(),
      routes: MyRoutes.routes,
      initialRoute: MyRoutes.initialRoute(),
    );
  }
}
