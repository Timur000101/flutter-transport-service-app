import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/start_up.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging =  FirebaseMessaging();
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  AndroidInitializationSettings androidInitializationSettings = new AndroidInitializationSettings('@mipmap/ic_launcher');
  IOSInitializationSettings iosInitializationSettings = new IOSInitializationSettings();


  @override
  Widget build(BuildContext context) {
    InitializationSettings initializationSettings = new InitializationSettings(
        android:  androidInitializationSettings, iOS:  iosInitializationSettings );
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.initialize(initializationSettings);
    _firebaseMessaging.requestNotificationPermissions();
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

  Future _showNotification(String title, String body) async {
    var androidDetails = new AndroidNotificationDetails("channelId", "channelName", "channelDescription");
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationsDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotificationsPlugin.show(0, title, body, generalNotificationsDetails);
  }



  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((deviceToke) {
      print(deviceToke);
      print('asd');
      sharedPreferences.setString(AppConstants.deviceToken, deviceToke);
    });
  }

  _configureFirebaseListeners() {

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotification(message["notification"]["title"], message["notification"]["body"]);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message["body"])));

        // setState(() {+
        //   this.msg = message.toString();
        // });
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // setState(() {
        //   this.msg = message.toString();
        // });
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // setState(() {
        //   this.msg = message.toString();
        // });
        // _navigateToItemDetail(message);
      },
    );
  }
}
