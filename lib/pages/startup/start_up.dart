import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sto_app/pages/home_page.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new HomePage(),
      title: new Text("CTO", textScaleFactor: 2,),
      image: new Image.asset('assets/images/splash_img.jpg'),
      loadingText: Text("Онлайн СТО"),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}