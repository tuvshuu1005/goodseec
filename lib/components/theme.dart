import 'package:flutter/material.dart';
import 'package:goodsec2/components/contants.dart';

ThemeData theme() {
  return ThemeData(
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: kPrimaryColor),
      textTheme: TextTheme(
          headline6: TextStyle(
        color: Colors.black,
        fontSize: 18,
      )),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
