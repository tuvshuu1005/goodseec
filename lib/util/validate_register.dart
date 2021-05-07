import 'package:age/age.dart';

String validateRegister(String value) {
  String _msg;
  RegExp regex =
      new RegExp(r'^[0-9]{2}[0-3]{1}[0-9]{1}[0-3]{1}[0-9]{1}[0-9]{2}$');
  if (value.isEmpty) {
    _msg = "Таны регистер хоосон байна";
  } else if (!regex.hasMatch(value)) {
    _msg = "Таны регистер буруу байна";
  } else if (isChild(value) == 1) {
    _msg = "Таны регистер буруу байна";
  }
  return _msg;
}

int isChild(String _register) {
  var resAge;
  DateTime today = DateTime.now();
  AgeDuration age;

  String jil = '', sar = '', udur = '';
  jil = _register.substring(2, 4);
  int year = int.parse(jil);
  sar = _register.substring(4, 6);
  int month = int.parse(sar);
  udur = _register.substring(6, 8);
  int day = int.parse(udur);

  if (year >= 1 && year <= 99 && month >= 1 && month <= 12 && day <= 31) {
    if (year.toString().length == 1) {
      year = int.parse('190$year');
    } else {
      year = int.parse('19$year');
    }
    DateTime birthday = DateTime(year, month, day);

    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
  } else if (day <= 31 && (month - 20 > 0 && month - 20 <= 12)) {
    if (year.toString().length == 1) {
      year = int.parse('200$year');
    } else {
      year = int.parse('20$year');
    }
    DateTime birthday = DateTime(year, month - 20, day);
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
  } else
    return 1;
  resAge = age.toString();

  List<String> trueAge = resAge.split(',');
  int realAge = int.parse(trueAge[0].split(' ')[1]);
  // resAge = trueAge[0].replaceAll('Years:', '');
  if (realAge >= 18) {
    return 3;
  } else
    return 2;
  // print("register dugaar = " + y + m + d);
}
