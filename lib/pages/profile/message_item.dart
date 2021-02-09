import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/message.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class MessageItem extends StatelessWidget {

  final Message message;

  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.red),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 10),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quaerat, ratione ...',
                        style: TextStyle(color: AppColors.primaryTextColor,)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
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
            )
          ],
        ),
      )
    ]);
  }
}
