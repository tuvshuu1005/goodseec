import 'package:flutter/material.dart';
import 'package:goodsec2/screens/forgot_LoginName_screen.dart';
import 'package:goodsec2/screens/forgot_password_screen.dart';
import 'package:goodsec2/screens/home_address_screen.dart';
import 'package:goodsec2/screens/home_page.dart';
import 'package:goodsec2/screens/mainScreen.dart';
import 'package:goodsec2/screens/sign_in_screen.dart';
import 'package:goodsec2/screens/verify_phone_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ForgotLoginNameScreen.routeName: (context) => ForgotLoginNameScreen(),
  VerifyPhone.routeName: (context) => VerifyPhone(),
  HomeAddress.routeName: (context) => HomeAddress(),
  HomePage.routename: (context) => HomePage(),
};
