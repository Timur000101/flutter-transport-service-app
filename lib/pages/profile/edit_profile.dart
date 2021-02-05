import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameTextField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: buildAppBar("Редактирование"),
         body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
              color: AppColors.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/Add_ava_placeholder.png", width: 100, height: 100),
                    )
                  ),
                  Text('Сменить фото', style: TextStyle(color: AppColors.mainColor, fontSize: 16, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,10,15,5),
                    child: TextField(
                      controller: nameTextField,
                      style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'ФИО',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5, left: 30, right: 30),
                          child: GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Row(
                                children: [
                                Text('Город', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                Spacer(),
                                Text('Алматы', style: TextStyle(fontSize: 13, color: AppColors.primaryTextColor)),
                                Icon(Icons.keyboard_arrow_right_outlined, size: 30),
                              ]),
                            )
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          child: GestureDetector(
                            onTap: (){
                              print('Change number');
                            },
                            child:Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Row(
                                children: [
                                Text('Сменить номер', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                Spacer(),
                                Text('+7 (778) 357-92-79', style: TextStyle(fontSize: 13, color: AppColors.primaryTextColor)),
                                Icon(Icons.keyboard_arrow_right_outlined, size: 30),
                              ]),
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,10,15,5),
                    child: TextField(
                      controller: nameTextField,
                      style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Дополнительный телефон 1',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,10,15,5),
                    child: TextField(
                      controller: nameTextField,
                      style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Дополнительный телефон 2',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,30,15,20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){
                          print('Сохранить');
                          },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.red)),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        textColor: Colors.white,
                        color: AppColors.mainColor,
                        elevation: 3.0,
                        child: Text(
                          "Сохранить",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ]
        )
        )
       ),
      )
    );
  }
}