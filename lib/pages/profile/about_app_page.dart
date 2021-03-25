import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'terms_of_use_page.dart';

class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("О приложении"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              "assets/images/Logo.png",
              height: MediaQuery.of(context).size.width/2,
              width: MediaQuery.of(context).size.width - 100,
            ),
          ),
          Text('Мобильное приложение - Bumper.kz', style: TextStyle(color: AppColors.primaryTextColor, fontSize: 14)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 2.5),
                  child: ListTile(
                    title: Text('Пользовательское соглашение', style: TextStyle(fontSize: 14)),
                    leading: Icon(Icons.warning, color: AppColors.mainColor, size: 30,),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    tileColor: Colors.white,
                    onTap: () async {
                      var url = "https://back.bumper-app.kz/users/private/policy/";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } 
                      else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                );
              }
            ),
          ),
          SizedBox(height: 20),
          Text('Мы в социальных сетях:', style: TextStyle(color: AppColors.mainTextColor, fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(onTap: () {
                  first();
                },
                child: Container(
                  padding: EdgeInsets.all(15),
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
                    child: Icon(Icons.face)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(onTap: () {
                  second();
                },
                child: Container(
                  padding: EdgeInsets.all(15),
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
                    child: Icon(Icons.insert_invitation)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(onTap: () {
                  third();
                },
                child: Container(
                  padding: EdgeInsets.all(15),
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
                    child: Icon(Icons.whatshot)
                  ),
                ),
              )
          ],),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Спасибо что выбрали нас!', style: TextStyle(color: AppColors.primaryTextColor, fontSize: 14)),
          ),
        ],),
      ),
    );
  }

  first(){
    print(1);
  }

  second(){
    print(2);
  }

  third(){
    print(3);
  }
}