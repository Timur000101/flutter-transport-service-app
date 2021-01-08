import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/menu_item.dart';
import 'package:sto_app/sto_icons_new_icons.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched = false;
  List<MenuItem> menu1 = [
    MenuItem(title: "Мои автомобили", icon: StoIconsNew.car_1),
    MenuItem(title: "История заказов", icon: Icons.history),
    MenuItem(title: "Сообщения", icon: StoIconsNew.conversation_2),
  ];

  List<MenuItem> menu2 = [
    MenuItem(title: "Служба поддержки", icon: StoIconsNew.customer_service_2),
    MenuItem(title: "Оценить приложение", icon: StoIconsNew.star_2),
    MenuItem(title: "О приложении", icon: Icons.warning_rounded)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Профиль"),
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildProfileHeader(context),
          SizedBox(
            height: 15,
          ),
          Container(margin: EdgeInsets.only(bottom: 5.0), padding: EdgeInsets.symmetric(horizontal: 15.0), child: Text("Основные", style: TextStyle(color: AppColors.primaryTextColor),)),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: menu1.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 2.5),
                child: ListTile(
                  title: Text(menu1[index].title, style: TextStyle(fontSize: 18, color: AppColors.mainTextColor)),
                  leading: Icon(menu1[index].icon, color: AppColors.mainColor, size: 30,),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  tileColor: Colors.white,
                ),
              );
            }),
            Container(margin: EdgeInsets.only(bottom: 5.0, top: 10.0), padding: EdgeInsets.symmetric(horizontal: 15.0), child: Text("Дополнительно", style: TextStyle(color: AppColors.primaryTextColor),)),
            ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: menu2.length,
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 2.5),
                child: ListTile(
                  title: Text(menu2[index].title, style: TextStyle(fontSize: 18, color: AppColors.mainTextColor)),
                  leading: Icon(menu2[index].icon, color: AppColors.mainColor, size: 30,),
                  trailing: Icon(Icons.keyboard_arrow_right_outlined),
                  tileColor: Colors.white,
                ),
              );
            }),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: RaisedButton(
              onPressed: () {},
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              textColor: Colors.white,
              color: AppColors.mainColor,
              elevation: 3.0,
              child: Text("Выйти из аккаунта"),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 235,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(20),
          color: Colors.white
      ),
      child: Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://thumbs.dreamstime.com/b/portrait-white-man-isolated-portrait-white-man-isolated-113528288.jpg"),
                        radius: 50,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Куанаев Темур".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontFamily: 'Montserrat SemiBold')),
                      Text(
                        "8 (702) 545-72-03",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.primaryTextColor),
                      ),
                      FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        onPressed: () {}, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.settings, color: Colors.blue,),
                            SizedBox(width: 5,),
                            Text("Редактировать", style: TextStyle(color: Colors.blue,))
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Column(children: <Widget>[
              Transform.scale(
                scale: 1.2,
                child: SizedBox(
                  child: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: AppColors.mainColor,
                    activeColor: Colors.white,
                  ),
                ),
              ),
              userRoleText(),
              SizedBox(height: 5.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8, 
                child: Text(
                  "Принимайте заказы в режиме исполнителей!",
                  style: TextStyle(color: AppColors.primaryTextColor, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              )
            ],)
          ],)
        ],
      ));
  }

  userRoleText() {
    return !isSwitched
        ? Text(
            "Заказчик",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat SemiBold',
            ),
          )
        : Text(
            "Исполнитель",
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat SemiBold',
            ),
          );
  }
}
