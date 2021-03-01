import 'dart:io';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/auth/signIn_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: isRegis(),
        builder: (context, AsyncSnapshot<void> snapshot) {
          return getSplashScreen(HomePage());
        });
  }

  Widget getSplashScreen(Widget wid) {
    return SplashScreen(
        seconds: 2,
        navigateAfterSeconds: wid,
        title: new Text(
          "Fast Service",
          textScaleFactor: 2,
        ),
        image: new Image.asset('assets/images/logo_FS_color.jpg'),
        loadingText: Text("from R&D"),
        photoSize: 110.0,
        loaderColor: Colors.red);
  }

  Future<void> isRegis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isReg = prefs.getBool(AppConstants.isReg);
    var isRegAsCto = prefs.getBool(AppConstants.isRegAsCto);
    var role = prefs.get(AppConstants.isClient);

    if (role == null) {
      role = false;
    }

    if (isReg != null) {
      AppConstants.isreg = isReg;
    }
    if (isRegAsCto != null) {
      AppConstants.isRegAsSTO = isRegAsCto;
    }
    if (role != null) {
      AppConstants.role = role;
    }
  }
}
