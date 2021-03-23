import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/pages/profile/my_cars_page.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;

import '../home_page.dart';

class ServiceFinishWash extends StatefulWidget {
  final int servicePK;

  ServiceFinishWash({this.servicePK});

  @override
  _ServiceFinishWashState createState() => _ServiceFinishWashState();
}

class _ServiceFinishWashState extends State<ServiceFinishWash> {
  final globalKey = GlobalKey<ScaffoldState>();
  List<Car> carList = new List<Car>();
  List<DropdownMenuItem> itemList = List<DropdownMenuItem>();
  Object _value;
  var carId = -1;

  void initState() {
    super.initState();
    getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Подробнее"),
      body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Выбирите машину", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.lightColor,
                    border: Border.all(color: AppColors.primaryTextColor)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: AppColors.lightColor,
                      hint: new Text("Выберите машину"),
                      value: _value,
                      items: itemList,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          carId = value;
                        });
                      }
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: (){
                    _createOrder(context);
                    },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.red)),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  textColor: Colors.white,
                  color: AppColors.mainColor,
                  elevation: 3.0,
                  child: Text(
                    "Создать",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    )
    );
  }


  _createOrder(BuildContext context) async {
    if (carId != -1){
      var token = await getToken();
      var uri = Uri.parse(AppConstants.baseUrl + 'order/');
      var request = new http.MultipartRequest("POST", uri);
      request.headers['authorization'] = "Token $token";
      request.fields['car_id'] = carId.toString();
      request.fields['service_id'] = widget.servicePK.toString();

      globalKey.currentState.showSnackBar(
        SnackBar(duration: new Duration(seconds: 360), content:
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
              Text("  Загрузка...  "),
            ],
          ),
        )
      );

      var response = await request.send();
      if (response.statusCode == 200){
        globalKey.currentState.hideCurrentSnackBar();
        final snackBar = SnackBar(content: Text('Удачно! Ждите заявок...'));
        globalKey.currentState.showSnackBar(snackBar);
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => HomePage( )), (Route<dynamic> route) => false
        );
      }
      else{
        print('Error');
      }
    }
    else{
      final snackBar = SnackBar(content: Text('Выберите машину или добавьте в профиле...'));
      globalKey.currentState.showSnackBar(snackBar);
    }

  }

  getCars() async {
    var token = await getToken();
    List<Car> list = await getMyCars(token);
    List<DropdownMenuItem> list1 = List<DropdownMenuItem>();
    int count = 0;
    for (var i in list){
      count+=1;
      list1.add(
        DropdownMenuItem(child: Text(i.name), value: i.id)
      );
    }
    setState(() {
      itemList = list1;
    });
  }
}
