import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/start_up.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.mainTextColor,
              fontFamily: 'Montserrat Regular'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:StartUp(),);
  }
}
