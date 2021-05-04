import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:goodsec2/components/TabIndicationPainterPortrait.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:goodsec2/screens/sign_in_screen.dart';
import 'package:goodsec2/screens/sign_up_screen.dart';

class MainScreen extends StatefulWidget {
  static String routeName = "/mainScreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isheight = true;
  bool isRememberMe = false;
  bool isLogin = true;
  TextEditingController loginEmailController =
      new TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  Color left = Colors.white;
  Color right = kPrimaryColor;
  PageController pageController = PageController();
  void onChangePage(int i) {
    if (i == 0) {
      isheight = true;
      right = Color(0xFFFF0036);
      left = Colors.white;
    } else if (i == 1) {
      isheight = false;
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
    ScreenUtil.init(context, width: 750, height: 1400, allowFontScaling: true);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2F3F7),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(150)),
            height: getProportionateScreenHeight(115),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/21.png"),
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
                    height: isheight ? 450 : 600,
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
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 40),
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
                                  new ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: Container(
                                      child: ListView(
                                        children: [
                                          SignInScreen(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  new ConstrainedBox(
                                    constraints: const BoxConstraints.expand(),
                                    child: Container(
                                      child: ListView(
                                        children: [
                                          SignUp(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                  "Нэвтрэх",
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
                  "Бүртгүүлэх",
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
}
