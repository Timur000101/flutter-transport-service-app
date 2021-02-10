import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

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
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              "assets/images/logo_FS_color.jpg",
              width: MediaQuery.of(context).size.width - 100,
            ),
          ),
          Text('Мобильное приложение - Bumper.kz', style: TextStyle(color: AppColors.primaryTextColor, fontSize: 14)),
          SizedBox(height: 40),
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => TermsOfUsePage()),
                      );
                    },
                  ),
                );
              }
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Спасибо что выбрали нас!', style: TextStyle(color: AppColors.primaryTextColor, fontSize: 14)),
          ),
        ],),
      ),
    );
  }
}