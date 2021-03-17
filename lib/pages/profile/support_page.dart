import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Служба поддержки"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              "assets/images/Logo.png",
              width: MediaQuery.of(context).size.width - 100,
              height: MediaQuery.of(context).size.width/2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text('Рады помочь! Служба поддержки Bumper.kz', style: TextStyle(color: AppColors.primaryTextColor, fontSize: 14)),
          ),
          GestureDetector(
            onTap: (){
              call();
            },
            child:Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.call, color:AppColors.mainColor ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Text(
                            'Позвонить',
                            style: TextStyle(color: AppColors.mainTextColor,fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '+7(777)312-10-39',
                          style: TextStyle(color: AppColors.mainTextColor,fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(Icons.arrow_forward_ios_rounded)
                  ),
                ],
              ),
            )
          ),
          GestureDetector(
            onTap: (){
              message();
            },
            child:Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.email, color:AppColors.mainColor ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Text(
                            'Написать',
                            style: TextStyle(color: AppColors.mainTextColor,fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          child: Text(
                            'bumperala@gmail.com',
                            style: TextStyle(color: AppColors.mainTextColor,fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(Icons.arrow_forward_ios_rounded)
                  ),
                ],
              ),
            )
          ),
          GestureDetector(
            onTap: (){
              visitSite();
            },
            child:Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.message, color:AppColors.mainColor ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Text(
                            'Посетить сайт',
                            style: TextStyle(color: AppColors.mainTextColor,fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          child: Text(
                            'bumper-app.kz',
                            style: TextStyle(color: AppColors.mainTextColor,fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.lightColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 1))
                        ]),
                    child: Icon(Icons.arrow_forward_ios_rounded)
                  ),
                ],
              ),
            )
          )
        ],),
      ),
    );
  }

  call(){
    launch("tel://+77783579279");
  }

  message(){
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@bumper.kz',
      queryParameters: {
        'subject': 'Example Subject & Symbols are allowed!'
      }
    );
    launch(_emailLaunchUri.toString());
  }

  visitSite() async {
    var url = "";
    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/";
    }
    if (Platform.isIOS) {
      url = 'https://apple.com';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } 
    else {
      throw 'Could not launch $url';
    }
  }
}