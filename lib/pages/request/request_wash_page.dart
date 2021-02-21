import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;
import 'about_auto_page.dart';


class RequestWashPage extends StatefulWidget {
  final RequestItem request;
  RequestWashPage({this.request});
  @override
  _RequestWashPageState createState() => _RequestWashPageState();
}

class _RequestWashPageState extends State<RequestWashPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final priceController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:SingleChildScrollView(
        reverse: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      widget.request.car.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(widget.request.subservice['name'] ,
                textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 16,
                    )),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Предложите свою цену:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.mainTextColor),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: myTextField(
                        priceController,
                        "Цена",
                        Icon(
                          Icons.money,
                          color: AppColors.primaryTextColor,
                        ),
                        "KZT",
                        TextInputType.number)),
                Text(
                  "Примерное время ремонта:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: myTextField(
                        timeController,
                        "Время",
                        Icon(
                          Icons.access_time_outlined,
                          color: AppColors.primaryTextColor,
                        ),
                        "",
                        TextInputType.text)),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0)),
                      child: Text(
                        "Посмотреть машину",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.red[600],
                      textColor: AppColors.lightColor,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAutoPage(car: widget.request.car)));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0)),
                      child: Text(
                        "Отправить",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.green[700],
                      textColor: AppColors.lightColor,
                      onPressed: () {
                        sendRequest();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    )
    );
  }

  final OutlineInputBorder myEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: AppColors.primaryTextColor,
    ),
  );
  final OutlineInputBorder myFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: AppColors.primaryTextColor),
  );

  Widget myTextField(TextEditingController contoller, String hintText,
      Icon icon, String suffixText, TextInputType textInputType) {
    return TextField(
        keyboardType: textInputType,
        controller: contoller,
        cursorColor: AppColors.primaryTextColor,
        decoration: InputDecoration(
          suffixText: suffixText,
          prefixIcon: icon,
          hintText: hintText,
          filled: true,
          fillColor: AppColors.lightColor,
          enabledBorder: myEnabledBorder,
          focusedBorder: myFocusedBorder,
        ));
  }

  sendRequest() async{
    if (priceController.text.length > 2){
      if (timeController.text.length > 1){
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        var token = sharedPreferences.getString(AppConstants.key);
        final response = await http.post(AppConstants.baseUrl + "order/request/create",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Accept": "application/json",
            "Authorization": "Token $token"
          },
          body: jsonEncode(<String, dynamic>{
            'order': widget.request.id,
            'price': priceController.text,
            'time': timeController.text,
          }
        ));
        if (response.statusCode == 200) {
          final snackBar = SnackBar(content: Text('Заявка отправлена, ждите...'));
          globalKey.currentState.showSnackBar(snackBar);
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
        } else {
          print("Falied");
        }
      }
      else{
        final snackBar = SnackBar(content: Text('Введите корректное время...'));
        globalKey.currentState.showSnackBar(snackBar);
      }
    }
    else{
      final snackBar = SnackBar(content: Text('Введите корректную цену...'));
      globalKey.currentState.showSnackBar(snackBar);
    }
  }
}
