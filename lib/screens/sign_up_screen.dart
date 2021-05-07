import 'package:flutter/material.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/default_button.dart';
import 'package:goodsec2/components/dialog.dart';
import 'package:goodsec2/components/register.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:goodsec2/models/list_country.dart';

import 'package:goodsec2/screens/verify_phone_screen.dart';

import 'package:goodsec2/util/validate_register.dart';
import 'package:goodsec2/util/validators.dart';
import 'package:age/age.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String firstNumber = "A";
  String secondNumber = "A";
  List<ListCountry> _dropdownItems = [
    ListCountry(1, "Монгол"),
    ListCountry(2, "Бусад"),
  ];
  List<DropdownMenuItem<ListCountry>> _dropdownMenuItems;
  ListCountry _selectedItem;
  String lname = '', fname = '', register = '', phone = '', email = '';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
    super.initState();
  }

  void registerApi(
      String firstname,
      String lastname,
      String register,
      String occupation,
      String phone,
      String email,
      String country,
      ageCheck) async {
    String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/CustomerWebService/check_customer_register";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";
    Map<String, String> datasss = {
      "firstname": firstname,
      "lastname": lastname,
      "register": register,
      "occupation": occupation,
      "phone": phone,
      "email": email,
      "country": country
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
    var responseBody = utf8.decode(datas.runes.toList());
    var jsonData = json.decode(responseBody);
    if (jsonData['responseResultType'] == "SUCCESS") {
      if (country == "1" && ageCheck == 3) {
        selectPhoneOrEmail(context, "дугаарт", phone, email, country);
      } else if (country == "2" && ageCheck == 3) {
        selectPhoneOrEmail(context, "имэйлд", phone, email, country);
      } else if (ageCheck == 2) {
        selectPhoneOrEmail(context, "Утас", phone, email, country);
      } else {
        var responseBody = utf8.decode(datas.runes.toList());
        print(responseBody);
      }
    } else {
      print("response:  " + jsonData.toString());
      if (jsonData['responseResultType'] == "FAILURE") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                descriptions: jsonData['failureMessages']['message'][0]
                        ['failureMessage']
                    .toString(),
                text: "Хаах",
              );
            });
      }
    }
  }

  List<DropdownMenuItem<ListCountry>> buildDropDownMenuItems(
      List listCountrys) {
    List<DropdownMenuItem<ListCountry>> items = List();
    for (ListCountry listCountry in listCountrys) {
      items.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Text(
                listCountry.name,
                style: TextStyle(color: Color(0xFFFF0036)),
              ),
            ],
          ),
          value: listCountry,
        ),
      );
    }
    return items;
  }

  void selectPhoneOrEmail(BuildContext ctx, String title, String phone,
      String email, String country) {
    Navigator.of(ctx).pushNamed(VerifyPhone.routeName, arguments: {
      'title': title,
      "phone": phone,
      "email": email,
      "country": country
    });
  }

  @override
  Widget build(BuildContext context) {
    final lnameField = TextFormField(
      validator: (value) => value.isEmpty ? "Овогоо оруулна уу" : null,
      onSaved: (value) => lname = value,
      decoration: InputDecoration(labelText: "Овог"),
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
    );

    final fnameField = TextFormField(
      validator: (value) => value.isEmpty ? "Нэрээ оруулна уу" : null,
      onSaved: (value) => fname = value,
      decoration: InputDecoration(labelText: "Нэр"),
      textInputAction: TextInputAction.next,
      cursorColor: kPrimaryColor,
    );

    final registerField = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Регистрийн дугаар",
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
                        ),
                      ),
                    );
                  });
                },
                child: Container(
                  height: 30,
                  child: Row(
                    children: [
                      Text(firstNumber),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 15,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                    height: 30,
                    child: Row(
                      children: [
                        Text(secondNumber),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 15,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: validateRegister,
                    onSaved: (value) =>
                        register = firstNumber + secondNumber + value,
                    decoration: InputDecoration(),
                  ),
                ),
              ),
            ],
          )
        ]);

    final countryField = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Бүртгүүлж буй улс*",
        ),
        DropdownButton(
            dropdownColor: Color(0xFFF2F3F7),
            isExpanded: true,
            value: _selectedItem,
            items: _dropdownMenuItems,
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
                print('tanii id ' + _selectedItem.value.toString());
              });
            })
      ],
    );

    final phoneField = TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) => value.length > 0 && value.length == 8
          ? null
          : "Таны утасны дугаар буруу байна",
      onSaved: (value) => phone = value,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Утас",
      ),
      cursorColor: kPrimaryColor,
      textInputAction: TextInputAction.next,
    );
    final emailField = TextFormField(
      validator: validateEmail,
      onSaved: (value) => email = value,
      decoration: InputDecoration(labelText: "Имэйл"),
      textInputAction: TextInputAction.done,
      cursorColor: kPrimaryColor,
    );

    return Form(
      key: _formKey,
      child: Theme(
        child: Container(
          child: Column(
            children: [
              _buildSignUpRow(lnameField),
              _buildSignUpRow(fnameField),
              SizedBox(height: getProportionateScreenHeight(20)),
              _buildSignUpRow(registerField),
              _buildSignUpRow(phoneField),
              _buildSignUpRow(emailField),
              SizedBox(height: getProportionateScreenHeight(20)),
              _buildSignUpRow(countryField),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "Бүртгүүлэх",
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    int ageCheck = isChild(register);
                    print("nas = " + ageCheck.toString());
                    if (ageCheck == 3) {
                      registerApi(fname, lname, register, "1", phone, email,
                          _selectedItem.value.toString(), ageCheck);
                    } else {
                      registerApi(fname, lname, register, "5", phone, email,
                          _selectedItem.value.toString(), ageCheck);
                    }
                  }
                },
              ),
            ],
          ),
        ),
        data: Theme.of(context).copyWith(
          primaryColor: Colors.redAccent,
        ),
      ),
    );
  }

  int isChild(String _register) {
    var resAge;
    print('-----$_register');
    DateTime today = DateTime.now();
    print('-----------------$today ');
    AgeDuration age;

    String jil = '', sar = '', udur = '';
    jil = _register.substring(2, 4);
    int year = int.parse(jil);
    print(year);
    sar = _register.substring(4, 6);
    int month = int.parse(sar);
    udur = _register.substring(6, 8);
    int day = int.parse(udur);

    print('on sar $jil $sar $udur');
    if (year >= 1 && year <= 99 && month >= 1 && month <= 12 && day <= 31) {
      if (year.toString().length == 1) {
        year = int.parse('190$year');
      } else {
        year = int.parse('19$year');
      }
      DateTime birthday = DateTime(year, month, day);
      age = Age.dateDifference(
          fromDate: birthday, toDate: today, includeToDate: false);
      print('Your age is --$age');
    } else if (day <= 31 && (month - 20 > 0 && month - 20 <= 12)) {
      if (year.toString().length == 1) {
        year = int.parse('200$year');
      } else {
        year = int.parse('20$year');
      }
      DateTime birthday = DateTime(year, month - 20, day);
      age = Age.dateDifference(
          fromDate: birthday, toDate: today, includeToDate: false);
      print('Your age is $age');
    } else
      return 1;
    resAge = age.toString();

    List<String> trueAge = resAge.split(',');
    int realAge = int.parse(trueAge[0].split(' ')[1]);
    print('------true age $realAge');

    if (realAge >= 18) {
      // above 18 age
      return 3;
    } else
      // below 18 age
      return 2;
  }

  Widget _buildSignUpRow(Widget child) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: child);
  }
}
