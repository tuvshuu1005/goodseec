import 'package:flutter/material.dart';
import 'package:goodsec2/components/size_config.dart';

const kPrimaryColor = Color(0xFFFF0036);
const kPrimaryLightColor = Color(0xFF900020);
const kTextColor = Color(0xFFFFFFFF);
const Color textColor1 = Color(0xFFA7BCC7);
const Color textColor2 = Color(0xFF9Bb3C0);

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kPrimaryColor),
  );
}
