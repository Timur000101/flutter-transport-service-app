// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: Container(
        child: Center(
          child: Text("Страница заявки", style: TextStyle(color: AppColors.mainTextColor),),
        ),
      )
    );
  }
}
