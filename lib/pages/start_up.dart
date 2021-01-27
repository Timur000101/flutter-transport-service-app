import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
// import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/pages/auth/signIn_page.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new SignIn(),
      title: new Text(
        "Fast Service",
        textScaleFactor: 2,
      ),
      image: new Image.asset('assets/images/logo_FS_color.jpg'),
      loadingText: Text("from R&D"),
      photoSize: 110.0,
      loaderColor: Colors.red,
    );
  }
}
