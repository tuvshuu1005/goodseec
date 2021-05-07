import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/default_button.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:goodsec2/screens/home_address_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timer_builder/timer_builder.dart';

class VerifyPhone extends StatefulWidget {
  static String routeName = "/phone";

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  TextEditingController textEditingController = TextEditingController();
  DateTime alert;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  Timer _timer;
  int _start;
  String conCode = "";
  @override
  void initState() {
    alert = DateTime.now().add(Duration(seconds: 10));
    super.initState();
  }

  void checkPhone(
      String confirmCode, String phone, String email, String country) async {
    String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/UserWebService/confirm_phone";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";

    Map<String, String> datasss = {
      "confirmCode": confirmCode,
      "phone": phone,
      "email": email,
      "country": country,
    };
    String data = datasss.toString();
    print("server to data" + data);
    var response = await http.post(url, headers: {
      "Accept": "application/json",
      'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
      'Authorization': auth,
    }, body: {
      "data": data,
    });

    var datas = response.body;
    var jsonData = json.decode(datas);
    var responseBody = utf8.decode(datas.runes.toList());
    print("data = $responseBody");
    if (jsonData['responseResultType'] == "SUCCESS") {
      Navigator.pushNamed(context, HomeAddress.routeName);
    }
    print("data = $responseBody");
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    final phone = routeArgs['phone'];
    final email = routeArgs['email'];
    final country = routeArgs['country'];
    print('title =  $title');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Баталгаажуулалт"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Text(
                    "Бид таны  ${security((country == "2") ? email : phone)}  $title код илгээлээ.",
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: true,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor:
                                hasError ? kPrimaryColor : Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.white,
                            )
                          ],
                          onCompleted: (v) {
                            print("Completed");
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(100),
                  ),
                  DefaultButton(
                      text: "Үргэлжлүүлэх",
                      press: () {
                        print("phone: " +
                            "$phone" +
                            " email: " +
                            "$email" +
                            " country: " +
                            "$country");
                        checkPhone(textEditingController.text.toString(),
                            "$phone", "$email", "$country");
                      }),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  buildTimer(context),
                ],
              ),
            ),
          ),
        ));
  }

  String security(String contact) {
    String res = '';
    int len = 0;
    if (contact != null && contact.length > 0) {
      if (contact.contains('@')) {
        len = contact.indexOf('@');
      } else {
        len = contact.length;
      }
      for (int i = 0; i < contact.length; i++) {
        if (i < len && len - i <= 4) {
          res = res + '*';
        } else
          res += contact[i];
      }
      return res;
    } else
      return res = '';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget buildTimer(context) {
    return TimerBuilder.scheduled([alert], builder: (context) {
      var now = DateTime.now();
      var reached = now.compareTo(alert) >= 0;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !reached
                ? TimerBuilder.periodic(Duration(seconds: 1),
                    alignment: Duration.zero, builder: (context) {
                    var now = DateTime.now();
                    var remaining = alert.difference(now);
                    return Text(
                      formatDuration(remaining),
                    );
                  })
                : InkWell(
                    onTap: () {
                      setState(() {
                        alert = DateTime.now().add(Duration(seconds: 10));
                      });
                    },
                    child: Text(
                      "Код дахин илгээх",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
          ],
        ),
      );
    });
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }
}
