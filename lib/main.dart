import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/auth/signIn_page.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/start_up.dart';


// import 'package:sto_app/pages/start_up.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    getRole();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.mainTextColor,
              fontFamily: 'Montserrat Regular'),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }


  getRole() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var isReg = sharedPreferences.getBool(AppConstants.isReg);
    if (isReg) {
      var role = sharedPreferences.getBool(AppConstants.isClient);
      AppConstants.role = role;
    }
  }
}
