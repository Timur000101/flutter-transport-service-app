import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/active_order_customer.dart';
import 'package:sto_app/models/order_history.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;



class OrderActiveItem extends StatelessWidget {
  final ActiveOrderCustomer active;

  OrderActiveItem({Key key, this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.lightColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 1))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "7 янв. 2021г",
                    style: TextStyle(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.primaryTextColor),
                      Text(
                        "Алматы",
                        style: TextStyle(color: AppColors.primaryTextColor),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                 active.car.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  active.service.name == "Мойка" ? "":
                  active.subservice.name,
                  style: TextStyle(color: AppColors.primaryTextColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                     active.service.name,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "16500 KZT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    MaterialButton(
                      color: AppColors.greenColor,
                      height: 26,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Text(
                        "Подробнее",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
  // void whatsAppOpen(String phone,message) async {
  //   String url = "whatsapp://send?phone=$phone%text=$message";
  //   await  launch(url);

  // }

  void finishOrder(context) async{
    var token = await getToken();
    http.Response response =
    await http.post("${AppConstants.baseUrl}order/finish/${active.id}", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> status = jsonDecode(response.body);
      if (status['status'] == "ok") {
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Заказ завершен")));
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load active order');
    }
  }

  String avaURL =
      "https://www.sunsetlearning.com/wp-content/uploads/2019/09/User-Icon-Grey.png";

  Color getGreenColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.greenColor;
    }
    return AppColors.greenColor;
  }

  Color getRedColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red[600];
    }
    return Colors.red[600];
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CircleAvatar(
                backgroundImage: NetworkImage(avaURL),
                radius: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                active.service.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Text(active.owner.phone,
                style: TextStyle(color: AppColors.primaryTextColor)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        var phone = "77781661021";
                        _launchURL(phone);
                        // whatsAppOpen(phone, "");
                        // var message = "hi";
                        // urlMessage(message, phone);
                      },
                      icon: Icon(Icons.message),
                      label: Text("Написать"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              getGreenColor))),
                  ElevatedButton.icon(
                      onPressed: () {
                        launch("tel://214324234");
                      },
                      icon: Icon(Icons.call),
                      label: Text("Позвонить"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              getGreenColor))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:AppConstants.role ? Text(
                "Вы подтверждаете завершение?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ): null,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:AppConstants.role ? ElevatedButton(
                  onPressed: () {
                    finishOrder(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 30),
                    child:  Text(
                      "Завершить заказ",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith(getRedColor),
                  )): null,
            )
          ],
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
  _launchURL(phone) async {
    var url = "https://wa.me/$phone";

    // if (Platform.isAndroid) {
    //   url = "https://play.google.com/store/apps/";
    // }
    // if (Platform.isIOS) {
    //   url = 'https://apple.com';
    // }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


  // String urlMessage(String message, String phone) {
  //   if (Platform.isAndroid) {
  //     // add the [https]
  //     return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
  //   } else {
  //     // add the [https]
  //     return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
  //   }
  // }

