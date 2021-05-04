import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodsec2/components/default_button.dart';
import 'package:goodsec2/components/size_config.dart';
import 'package:goodsec2/models/list_country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeAddress extends StatefulWidget {
  static String routeName = "/home_address";

  @override
  _HomeAddressState createState() => _HomeAddressState();
}

class _HomeAddressState extends State<HomeAddress> {
  void initState() {
    getProvince();
    super.initState();
  }

  /* Province */
  List<ListCountry> province = [];
  List<DropdownMenuItem<ListCountry>> _dropdownProvinceItem;
  ListCountry _selectedProvince;
  String homeAddress = '';
  final _formKey = GlobalKey<FormState>();
  final String url =
      "http://103.48.116.95:8084/project.broker.admin/rest/Customer/ReferenceWebService/get_province";
  String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";

  void getProvince() async {
    var responseProvince = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
        'Authorization': auth,
      },
    );
    setState(() {
      var dataProvince = responseProvince.body;
      var responseProvinceBody = utf8.decode(dataProvince.runes.toList());
      print("data = $responseProvinceBody");
      var serverProvinceData = json.decode((responseProvinceBody))['datas'];
      province = [];
      for (var i = 0; i < serverProvinceData.length; i++) {
        province.add(
          ListCountry.fromJson(serverProvinceData[i]),
        );
      }

      _dropdownProvinceItem = buildDropDownProvinceItem(province);
      _selectedProvince = _dropdownProvinceItem[0].value;
      print("_selectedProvince" + _selectedProvince.name);
    });
  }

  List<DropdownMenuItem<ListCountry>> buildDropDownProvinceItem(
      List listProvinces) {
    List<DropdownMenuItem<ListCountry>> itemsProvince = List();
    for (ListCountry listProvice in listProvinces) {
      itemsProvince.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Text(
                listProvice.name,
                style: TextStyle(color: Color(0xFFFF0036)),
              ),
            ],
          ),
          value: listProvice,
        ),
      );
    }
    return itemsProvince;
  }

/* District */
  List<ListCountry> district = [];
  List<DropdownMenuItem<ListCountry>> _dropdownDistrictItem;
  ListCountry _selectedDistrict;

  void getDistrict(String id) async {
    print("id===" + id.toString());
    final String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/ReferenceWebService/get_district";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";
    var responseDistrict = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
      'Authorization': auth,
    }, body: {
      'provinceId': id,
    });
    setState(() {
      var dataDistrict = responseDistrict.body;
      var responseDistrictBody = utf8.decode(dataDistrict.runes.toList());
      var serverDistrictData = json.decode((responseDistrictBody))['datas'];
      print("dataxaxa = $responseDistrictBody");
      district = [];
      for (var i = 0; i < serverDistrictData.length; i++) {
        district.add(ListCountry.fromJson(serverDistrictData[i]));
      }
      _dropdownDistrictItem = buildDropDownDistrictItems(district);
      _selectedDistrict = _dropdownDistrictItem[0].value;
      print("name" + _selectedDistrict.toString());
    });
  }

  List<DropdownMenuItem<ListCountry>> buildDropDownDistrictItems(
      List listDistricts) {
    List<DropdownMenuItem<ListCountry>> itemsDistrict = List();
    for (ListCountry listDistrict in listDistricts) {
      itemsDistrict.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Text(
                listDistrict.name,
                style: TextStyle(color: Color(0xFFFF0036)),
              ),
            ],
          ),
          value: listDistrict,
        ),
      );
    }
    return itemsDistrict;
  }

//getKhoroo
  List<ListCountry> khoroo = [];
  List<DropdownMenuItem<ListCountry>> _dropdownKhorooItem;
  ListCountry _selectedKhoroo;

  void getKhoroo(String id) async {
    print("id===" + id.toString());
    final String url =
        "http://103.48.116.95:8084/project.broker.admin/rest/Customer/ReferenceWebService/get_khoroo";
    String auth = "Basic c3lzX2N1c3RvbWVyOnN5czEyMw==";
    var responseKhoroo = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': auth,
    }, body: {
      'districtId': id,
    });
    setState(() {
      var dataKhoroo = responseKhoroo.body;
      var responseKhorooBody = utf8.decode(dataKhoroo.runes.toList());
      var serverKhorooData = json.decode((responseKhorooBody))['datas'];
      print("datairlee = $responseKhorooBody");
      khoroo = [];
      for (var i = 0; i < serverKhorooData.length; i++) {
        khoroo.add(ListCountry.fromJson(serverKhorooData[i]));
      }
      _dropdownKhorooItem = buildDropDownKhorooItems(khoroo);
      _selectedKhoroo = _dropdownKhorooItem[0].value;
      print("name" + _selectedKhoroo.toString());
    });
  }

  List<DropdownMenuItem<ListCountry>> buildDropDownKhorooItems(
      List listKhoroos) {
    List<DropdownMenuItem<ListCountry>> itemsKhoroo = List();
    for (ListCountry listKhoroo in listKhoroos) {
      itemsKhoroo.add(
        DropdownMenuItem(
          child: Row(
            children: <Widget>[
              Text(
                listKhoroo.name,
                style: TextStyle(color: Color(0xFFFF0036)),
              ),
            ],
          ),
          value: listKhoroo,
        ),
      );
    }
    return itemsKhoroo;
  }

  @override
  Widget build(BuildContext context) {
    final provinceField = DropdownButton(
        hint: Text('Ta Аймаг/Хотоо оруулна уу'),
        dropdownColor: Color(0xFFF2F3F7),
        isExpanded: true,
        value: _selectedProvince,
        items: _dropdownProvinceItem,
        onChanged: (value) {
          setState(() {
            _selectedProvince = value;
            print("dataProvince" + _selectedProvince.value.toString());
            if (_selectedProvince != null) {
              getDistrict("${_selectedProvince.value.toString()}");
            }
          });
        });
    final districtField = DropdownButton(
        hint: Text('Ta сонголтоо оруулна уу'),
        dropdownColor: Color(0xFFF2F3F7),
        isExpanded: true,
        value: _selectedDistrict,
        items: _dropdownDistrictItem,
        onChanged: (value) {
          setState(() {
            _selectedDistrict = value;
            print("this is:" + _selectedDistrict.value.toString());
            if (_selectedDistrict != null) {
              getKhoroo("${_selectedDistrict.value.toString()}");
            }
          });
        });
    final khorooField = DropdownButton(
        hint: Text('Ta сонголтоо оруулна уу'),
        dropdownColor: Color(0xFFF2F3F7),
        isExpanded: true,
        value: _selectedKhoroo,
        items: _dropdownKhorooItem,
        onChanged: (value) {
          setState(() {
            _selectedKhoroo = value;
            print("Id" + _selectedKhoroo.value.toString());
          });
        });
    final homeAddressField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Оршин суугаа хаягаа оруулна уу" : null,
      onSaved: (value) => homeAddress = value,
      decoration: InputDecoration(labelText: "Оршин суугаа хаяг:"),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setHeight(150),
              top: ScreenUtil().setHeight(150),
            ),
            height: getProportionateScreenHeight(100),
            child: Text(
              "Та байнгын оршин суудаг хаягаа оруулна уу",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    child: Theme(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            _buildAddressRow(provinceField),
                            _buildAddressRow(districtField),
                            _buildAddressRow(khorooField),
                            _buildAddressRow(homeAddressField),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: DefaultButton(
                                text: "Бүртгүүлэх",
                                press: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      data: Theme.of(context).copyWith(
                        primaryColor: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddressRow(Widget child) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: child);
  }
}
