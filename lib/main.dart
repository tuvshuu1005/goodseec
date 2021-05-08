import 'package:flutter/material.dart';

import 'package:goodsec2/components/theme.dart';
import 'package:goodsec2/routs.dart';
import 'package:goodsec2/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: MainScreen.routeName,
      routes: routes,
    );
  }
}
