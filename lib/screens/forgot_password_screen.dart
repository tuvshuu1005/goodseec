import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodsec2/components/TabIndicationPainterPortrait.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/default_button.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:goodsec2/screens/forgot_LoginName_screen.dart';
import 'package:goodsec2/util/validators.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = "/forgot_password";
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isEmailorPhone = true;
  Color left = Colors.white;
  Color right = kPrimaryColor;
  String loginName = '', email = '', phone = '', ip = '127.0.0.1';
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void forgotApi(
    String username,
    String phone,
    String ip,
    String email,
  ) async {
    String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/UserWebService/get_reset_code";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";

    Map<String, dynamic> dataToServer;
    if (phone == "" && email.length > 0) {
      dataToServer = {"username": username, "ip": ip, "email": email};
    } else if (email == "" && phone.length > 0) {
      dataToServer = {"username": username, "ip": ip, "phone": email};
    }

    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Authorization': auth,
        },
        body: dataToServer);
    var data = response.body;
    print("jsonData" + data);
  }

  PageController pageController = PageController();
  void onChangePage(int i) {
    if (i == 0) {
      isEmailorPhone = true;
      right = Color(0xFFFF0036);
      left = Colors.white;
    } else if (i == 1) {
      isEmailorPhone = false;
      right = Colors.white;
      left = Color(0xFFFF0036);
    }
    setState(() {});
  }

  void onSignUpButtonPress(PageController pageController) {
    print('onSign');
    pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void onSignInButtonPress(PageController pageController) {
    print('onSign');
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    Widget loginNameField = TextFormField(
        autofocus: false,
        validator: (value) =>
            value.isEmpty ? "Та нэвтрэх нэрээ оруулна уу" : null,
        onSaved: (value) => loginName = value,
        decoration: InputDecoration(
            labelText: "Нэвтрэх нэр",
            suffix: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ForgotLoginNameScreen.routeName);
                print('hi');
              },
              child: Text('Мартсан?'),
            )));

    Widget phoneField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Та утсаа оруулна уу" : null,
      onSaved: (value) => phone = value,
      decoration: InputDecoration(labelText: "Утас"),
    );
    Widget emailField = TextFormField(
      validator: validateEmail,
      onSaved: (value) => email = value,
      decoration: InputDecoration(labelText: "Имэйл"),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Нууц үг сэргээх"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(100),
                right: ScreenUtil().setHeight(250),
                left: ScreenUtil().setHeight(250),
              ),
              height: getProportionateScreenHeight(90),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/icon.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                    child: Container(
                      height: getProportionateScreenHeight(400),
                      width: getProportionateScreenWidth(320),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            blurRadius: 15,
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                      child: Container(
                        height: ScreenUtil().setHeight(600),
                        color: Colors.white,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 40, bottom: 10),
                                  child: buildMenuBarPortrait(context)),
                              Expanded(
                                flex: 2,
                                child: PageView(
                                  controller: pageController,
                                  onPageChanged: (i) {
                                    if (i == 1) {
                                      FocusScope.of(context).unfocus();
                                    }
                                    onChangePage(i);
                                  },
                                  children: <Widget>[
                                    isEmailorPhone
                                        ? phoneOrEmail(loginNameField,
                                            phoneField, loginName, phone)
                                        : Container(),
                                    !isEmailorPhone
                                        ? phoneOrEmail(loginNameField,
                                            emailField, loginName, email)
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget phoneOrEmail(Widget loginNameField, Widget phoneField, String name,
      String emailORphone) {
    print("name = $name $emailORphone");
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Container(
        child: Theme(
          child: ListView(
            children: [
              _buildSignUpRow(loginNameField),
              _buildSignUpRow(phoneField),
              SizedBox(height: getProportionateScreenHeight(30)),
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: DefaultButton(
                    text: "Илгээх",
                    press: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        if (isEmailorPhone) {
                          forgotApi(loginName, phone, ip, "");
                        } else {
                          forgotApi(loginName, "", ip, email);
                        }
                      }
                    }),
              ),
            ],
          ),
          data: Theme.of(context).copyWith(
            primaryColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }

  Widget buildMenuBarPortrait(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(540),
      height: ScreenUtil().setHeight(70),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F7),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: CustomPaint(
        painter: TabIndicationPainterPortrait(pageController: pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {
                  onSignInButtonPress(pageController);
                },
                child: Text(
                  "Утас",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: left,
                      fontSize:
                          ScreenUtil().setSp(30, allowFontScalingSelf: false),
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () {
                  onSignUpButtonPress(pageController);
                },
                child: Text(
                  "Имэйл",
                  style: TextStyle(
                      color: right,
                      fontSize:
                          ScreenUtil().setSp(30, allowFontScalingSelf: false),
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpRow(Widget child) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: child);
  }
}
