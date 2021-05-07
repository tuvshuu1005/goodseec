import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodsec2/components/contants.dart';

class HomePage extends StatelessWidget {
  static String routename = "homepage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Баталгаажуулалт"),
      ),
      body: Container(
        child: Text(
          "Тавтай морилно уу",
          style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setHeight(20)),
        ),
      ),
    );
  }
}
