import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Заявки", style: TextStyle(color: AppColors.mainTextColor)),
        backgroundColor: AppColors.backgroundColor,
        shadowColor: Colors.white,
        bottomOpacity: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text("Request page")
          ],
        ),
      ),
    );
  }
}