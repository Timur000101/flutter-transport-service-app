import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/auth/signIn_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    return FutureBuilder<bool>(
      future: isRegis(),
      builder: (context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData) {
            return snapshot.data ? getSplashScreen(HomePage()) : getSplashScreen(SignIn());
        }
        else {
            return getSplashScreen(SignIn());
        }
      }
    );
  }
    Widget getSplashScreen(Widget wid) {
      return  SplashScreen(
        seconds: 2,
        navigateAfterSeconds:wid,
        title: new Text(
          "Fast Service",
          textScaleFactor: 2,
        ),
        image: new Image.asset('assets/images/logo_FS_color.jpg'),
        loadingText: Text("from R&D"),
        photoSize: 110.0,
        loaderColor: Colors.red);
}
  Future<bool> isRegis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var r = prefs.getBool(AppConstants.isReg);
    if (r == null) {
      r = false;
    }
    return r;
  }
}
