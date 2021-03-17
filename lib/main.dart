import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/start_up.dart';
import 'package:sto_app/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    _getToken();
    _configureFirebaseListeners();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.mainTextColor,
            fontFamily: 'Montserrat Regular'),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartUp(),
    );
  }

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((deviceToke) {
      sharedPreferences.setString(AppConstants.deviceToken, deviceToke);
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print("onMessage: $message");
        // setState(() {
        //   this.msg = message.toString();
        // });
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message");
        // setState(() {
        //   this.msg = message.toString();
        // });
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume: $message");
        // setState(() {
        //   this.msg = message.toString();
        // });
        // _navigateToItemDetail(message);
      },
    );
  }
}
