import 'package:flutter/material.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/default_button.dart';
import 'package:goodsec2/components/dialog.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:goodsec2/screens/forgot_password_screen.dart';
import 'package:goodsec2/screens/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String loginName = '', password = '', ip = '127.0.0.1';
  bool remember = false;
  void loginApi(
    String username,
    String password,
    String ip,
  ) async {
    String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/UserWebService/login";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";
    Map<String, dynamic> datas = {
      "username": username,
      "password": password,
      "ip": ip,
    };
    //print("server to data" + datas.toString());
    // String data = datas.toString();
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Authorization': auth,
        },
        body: datas);
    var datass = response.body;
    var responseBody = utf8.decode(datass.runes.toList());
    print("server tt " + response.body);
    var jsonData = json.decode(responseBody);
    print("json data" + jsonData.toString());
    if (jsonData['responseResultType'] == "SUCCESS") {
      Navigator.pushNamed(context, HomePage.routename);
    } else if ((jsonData['responseResultType'] == "FAILURE")) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              // icn: Icon(Icons.ac_unit),
              // jsonData['failureMessages']['message'][0]['failureCode']
              //     .toString(),
              descriptions: jsonData['failureMessages']['message'][0]
                      ['failureMessage']
                  .toString(),
              text: "Хаах",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Theme(
              child: Column(
                children: [buildLoginNameFormField(), buildPasswordFormField()],
              ),
              data: Theme.of(context).copyWith(
                primaryColor: Colors.redAccent,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
                Text(
                  "Нэвтрэх нэр сануулах",
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Нэвтрэх",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                loginApi(loginName, password, ip);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Нууц үг сэргээх",
                  style: TextStyle(
                      color: Color(0xFF33AE8E),
                      fontSize: getProportionateScreenHeight(15)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.done,
      onSaved: (value) => password = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'Та нууц үгээ оруулна уу';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, size: getProportionateScreenHeight(20)),
        labelText: "Нууц үг",
      ),
    );
  }

  TextFormField buildLoginNameFormField() {
    return TextFormField(
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onSaved: (value) => loginName = value,
      validator: (value) {
        if (value.isEmpty) {
          return 'Та нэвтрэх нэрээ оруулна уу';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, size: getProportionateScreenHeight(20)),
        labelText: "Нэвтрэх нэр",
      ),
    );
  }
}
