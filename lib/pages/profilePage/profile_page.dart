import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/sto_icons_new_icons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 0)
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                tooltip: "Back button",
                onPressed: (){},
              ),
            )
          )
        ),
        title: Text(
          "Профиль", 
          style: TextStyle(
            color: AppColors.mainTextColor,
            fontFamily: 'Montserrat Semibold',
            fontSize: 18
          )
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(StoIconsNew.edit, size: 40, color: AppColors.mainColor,),
            tooltip: "Edit Profile",
            onPressed: () {},
          ),
          SizedBox(width: 10,)
        ],
        backgroundColor: AppColors.backgroundColor,
        shadowColor: Colors.white,
        bottomOpacity: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1
                  )
                ]
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://thumbs.dreamstime.com/b/portrait-white-man-isolated-portrait-white-man-isolated-113528288.jpg"),
                      radius: 70,
                    ),
                    SizedBox(height: 10,),
                    Text("Куанаев Темур", 
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat SemiBold'
                      )
                    ),
                    Text("8 (777) 789-78-65",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat Regular',
                        color: AppColors.primaryTextColor
                      ),
                    ),
                    Transform.scale(
                      scale: 1.4,
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
                    )
                  ]
                ),
              )
            )
          ],
        )
      ),
    );
  }
}