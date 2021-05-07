import 'package:flutter/material.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/register.dart';
import 'package:goodsec2/components/size_config.dart';

import 'package:goodsec2/util/validate_register.dart';

class ForgotLoginNameScreen extends StatefulWidget {
  static String routeName = "/forgot_loginName";

  @override
  _ForgotLoginNameScreenState createState() => _ForgotLoginNameScreenState();
}

class _ForgotLoginNameScreenState extends State<ForgotLoginNameScreen> {
  String firstNumber = "А";
  String secondNumber = "А";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Нэвтрэх нэр сэргээх"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Та регистрийн дугаараа оруулна уу",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register(
                                      refresh: (String fNum) {
                                        setState(() {
                                          firstNumber = fNum;
                                        });
                                      },
                                    )));
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Container(
                        height: 35,
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Text(firstNumber),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register(
                                      refresh: (String sNum) {
                                        setState(() {
                                          secondNumber = sNum;
                                        });
                                      },
                                    )));
                      },
                      child: Container(
                        height: 35,
                        width: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              Text(
                                secondNumber,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: kPrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Container(
                        height: 35,
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          cursorColor: Colors.teal,
                          validator: validateRegister,
                          onSaved: (value) =>
                              firstNumber + secondNumber + value,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: kPrimaryColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 2, color: Colors.teal)),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 24.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 300,
                height: getProportionateScreenHeight(40),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Хайх',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        ));
  }
}
