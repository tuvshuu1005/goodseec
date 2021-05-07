import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 5 * (MediaQuery.of(context).size.width / 10),
      height: getProportionateScreenHeight(40),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            )),
      ),
    );
  }
}
