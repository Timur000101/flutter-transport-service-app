import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/order.dart';
import 'package:sto_app/utils/alert.dart';
import 'package:http/http.dart' as http;

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key key,
    @required this.order,
    @required this.index, 
    @required this.callback,
  }) : super(key: key);

  final Order order;
  final int index;
  final Function callback;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isSelected = true;
  String subserviceText;
  String timeText;

  @override
  void initState() {
    super.initState();
    if (widget.order.subservice != null){
      subserviceText = widget.order.subservice['name'];
      timeText = 'В течении: ';
    }
    else{
      subserviceText = 'Мойка';
      timeText = 'Запись: ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 20,
          shadowColor: Colors.black54,
          color: _isSelected ? Colors.white : HexColor("D4FFD0"),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.order.car.name,
                                style: new TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(subserviceText),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: HexColor("35953E"),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Text(
                                  widget.order.stoName.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: AppColors.primaryTextColor,
                                ),
                                Text("Алматы"),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(widget.order.price.toString() + ' тг',
                                  style: new TextStyle(fontSize: 18)),
                            ),
                            Text(timeText,
                                  style: new TextStyle(fontSize: 16)),
                            Text(widget.order.time + '  ',
                                  style: new TextStyle(fontSize: 16)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Stoappicons.distance,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0, right: 0.0),
                                    child: Text(
                                    widget.order.distance,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primaryTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(children: [
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        child: FlatButton(
                          minWidth: 110,
                          child: Text(
                            'Принять',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            setState(() {
                              accept();
                            });
                          },
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        child: FlatButton(
                          minWidth: 110,
                          child: Text(
                            'Отклонить',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: AppColors.primaryTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            decline();
                          },
                        ),
                      ),
                  ],),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  accept(){
    var dialog = CustomAlertDialog(
        title: "Внимание",
        message: "Вы уверены?",
        onPostivePressed: () {
          sendAccept();
        },
        positiveBtnText: 'Да',
        negativeBtnText: 'Нет');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  decline(){
    var dialog = CustomAlertDialog(
        title: "Внимание",
        message: "Вы уверены?",
        onPostivePressed: () {
          sendDecline();
        },
        positiveBtnText: 'Да',
        negativeBtnText: 'Нет');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  sendAccept() async{
    var token = await getToken();
    final response = await http.post(AppConstants.baseUrl + "order/accept/${widget.order.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      widget.callback ();
    } else {
      print("Falied");
    }
  }

  sendDecline() async{
    var token = await getToken();
    final response = await http.post(AppConstants.baseUrl + "order/decline/${widget.order.id}",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      widget.callback();
    } else {
      print("Falied");
    }
  }
}
