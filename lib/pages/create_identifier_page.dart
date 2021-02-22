import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:sto_app/widgets/app_widgets.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/create_identifier.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/profile/profile_page.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;

class CreateIdentifierPage extends StatefulWidget {
  CreateIdentifierPage({Key key}) : super(key: key);

  @override
  _CreateIdentifierPageState createState() => _CreateIdentifierPageState();
}

class _CreateIdentifierPageState extends State<CreateIdentifierPage> {

  final globalKey = GlobalKey<ScaffoldState>();
  final UnderlineInputBorder identifierBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey[300]));

  TextEditingController identifierFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Регистрация"),
      backgroundColor: AppColors.backgroundColor,
      key: globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Text(
                  "Хотите предложить свои услуги?!",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Montserrat SemiBold"),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset("assets/images/identifier.png"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 15,
                ),
                child: Text(
                    "Введите идентификатор предоставленный нашей компанией, если у вас его нет, обратитесь к модератору.",
                    style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 12,
                        fontFamily: "Montserrat Regular"),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: identifierFieldController,
                  maxLength: 10,
                  cursorColor: Colors.grey[600],
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[300],
                      filled: true,
                      counterText: "",
                      enabledBorder: identifierBorder,
                      focusedBorder: identifierBorder,
                      labelText: "Идентификатор",
                      hintText: "XXXXXXXXXX",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 36, left: 20, right: 20, bottom: 8),
                child: redButton(context, Colors.red[600], "Готово"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: greenButton(context, Colors.grey[500], "Отправить заявку"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget redButton(BuildContext context, Color color, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 17),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0)),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        color: color,
        textColor: AppColors.lightColor,
        onPressed: () async {
          sendID(identifierFieldController.text, context);

        },
      ),
    );
  }
  Widget greenButton(BuildContext context, Color color, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 17),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0)),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        color: color,
        textColor: AppColors.lightColor,
        onPressed: () async {
            sendRequestForId();

        },
      ),
    );
  }

  sendRequestForId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString(AppConstants.key);
    final response = await http.post(AppConstants.baseUrl + "users/autoservice/request/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        });
    if (response.statusCode == 200) {
      final snackBar = SnackBar(content: Text('Заявка отправлена! Ждите, с Вами свяжутся...'));
      globalKey.currentState.showSnackBar(snackBar);
      await Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
    }
  }

  // setState(() {
  // identifierFieldController.text = "f42980bcb6";
  // });
  sendID(String id, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString(AppConstants.key);
    final response = await http.post(AppConstants.baseUrl + "users/login/cto/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
        body: jsonEncode(<String, String>{
          'id': id,
        }));
    if (response.statusCode == 200) {
      print(response.body);
      var model = CreateIdentifier.fromJson(jsonDecode(response.body));
      AppConstants.isRegAsSTO = true;
      AppConstants.role = true;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(AppConstants.isRegAsCto, true);
      sharedPreferences.setString(AppConstants.ctoLogo, model.ctoLogo);
      sharedPreferences.setString(AppConstants.ctoName, model.ctoName);
      sharedPreferences.setString(AppConstants.ctoAddress, model.ctoAddress);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          HomePage()), (Route<dynamic> route) => false);
    } else {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //     HomePage()), (Route<dynamic> route) => false);
      throw Exception('Failed to send id.');
    }
  }
}
  