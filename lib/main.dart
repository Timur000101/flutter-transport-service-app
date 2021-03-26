import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
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
  final globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    InitializationSettings initializationSettings = new InitializationSettings(
        android:  androidInitializationSettings, iOS:  iosInitializationSettings );
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    localNotificationsPlugin.initialize(initializationSettings);
    if (Platform.isIOS) iOS_Permission();
    _configureFirebaseListeners(context);
    _getToken();

    return MaterialApp(
      key: globalKey,
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

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      // print("Settings registered: $settings");
    });
  }

  _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      // print('Registration Id: $token');
      sharedPreferences.setString(AppConstants.deviceToken, token);
    });
  }

  _configureFirebaseListeners(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onMessage: $message");
          final snackBar = SnackBar(content: Text(message['body']));
          globalKey.currentState.showSnackBar(snackBar);
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onLaunch: $message");
        }
      },
      onResume: (Map<String, dynamic> message) async {
        Map<String, dynamic> convertedMessage = _convertMessage(message);
        if(convertedMessage != null) {
          print("onResume: $message");
        }
      },
    );
  }

  Map<String, dynamic> _convertMessage(Map<String, dynamic> message) {
    try {
      if (Platform.isIOS) {
        return {
          'title': 'BUMPER.KZ',
          'body': message['aps']['alert'],
        };
      } else {
        return {
          'title': 'BUMPER.KZ',
          'body': message['notification']['body'],
        };
      }
    } catch (e) {
      return null;
    }
  }
}