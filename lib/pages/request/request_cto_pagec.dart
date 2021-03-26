import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/create_identifier_page.dart';
import 'package:sto_app/pages/request/about_auto_page.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:sto_app/core/const.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class RequestCtoPage extends StatefulWidget {
  final RequestItem request;

  RequestCtoPage(this.request);

  @override
  _RequestCtoPageState createState() => _RequestCtoPageState();
}

class _RequestCtoPageState extends State<RequestCtoPage> {
  CarouselSlider carouselSlider;
  final globalKey = GlobalKey<ScaffoldState>();
  final priceController = TextEditingController();
  final timeController = TextEditingController();

  int _current = 0;
  List imgList = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    for (var i in widget.request.orderImg){
      imgList.add(i['image']);
    }
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
              carouselSlider = CarouselSlider(
                height: 160.0,
                initialPage: 0,
                enlargeCenterPage: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                items: imgList.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTextColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(imgList, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.redAccent
                          : AppColors.primaryTextColor,
                    ),
                  );
                }),
              ),
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
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryTextColor)),
                child: Text(
                  widget.request.about ,
                ),
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
        maxLength: 20,
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

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  sendRequest() async{
    if (priceController.text.length > 2){
      if (timeController.text.length > 1){
        var token = await getToken();
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
        print(response.body);
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

  // goToPrevious() {
  //   carouselSlider.previousPage(
  //       duration: Duration(milliseconds: 300), curve: Curves.ease);
  // }

  // goToNext() {
  //   carouselSlider.nextPage(
  //       duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  // }
}
