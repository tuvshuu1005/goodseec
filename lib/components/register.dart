import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodsec2/components/contants.dart';
import 'package:goodsec2/components/size_config.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  final Function refresh;
  Register({this.refresh});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int letterIndex;
  String tempNum = "Р";
  List<String> letter = [
    'А',
    'Б',
    'В',
    'Г',
    'Д',
    'Е',
    'Ё',
    'Ж',
    'З',
    'И',
    'Й',
    'К',
    'Л',
    'М',
    'Н',
    'О',
    'Ө',
    'П',
    'Р',
    'С',
    'Т',
    'У',
    'Ү',
    'Ф',
    'Х',
    'Ц',
    'Ч',
    'Ш',
    'Щ',
    'Ъ',
    'Ы',
    'Ь',
    'Э',
    'Ю',
    'Я',
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        height: ScreenUtil().setHeight(1000),
        child: Column(
          children: [
            Text(
              'Регистрийн дугаараа оруулна уу',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              height: ScreenUtil().setHeight(700),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  crossAxisCount: 7,
                  childAspectRatio: 5 / 5,
                ),
                itemCount: letter.length,
                itemBuilder: (BuildContext cxt, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        letterIndex = index;
                        tempNum = letter[letterIndex];
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: letterIndex == index
                                ? kPrimaryColor
                                : Color(0xFFF2F3F7),
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: letterIndex == index
                            ? Colors.white
                            : Color(0xFFF2F3F7),
                      ),
                      child: Text(
                        letter[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: letterIndex == index
                              ? kPrimaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 5 * (MediaQuery.of(context).size.width / 10),
              height: getProportionateScreenHeight(60),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
                onPressed: () {
                  widget.refresh(tempNum);
                  Navigator.pop(context);
                },
                child: Text('Дараах',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
