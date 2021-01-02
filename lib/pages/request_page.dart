import 'dart:convert';
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
          title:
              Text("Заявки", style: TextStyle(color: AppColors.mainTextColor)),
          backgroundColor: AppColors.backgroundColor,
          shadowColor: Colors.white,
          bottomOpacity: 1,
        ),
        body: Center(
          child: FutureBuilder(builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemCount: showData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: showData[index]['model'] == "services.service" ? Text(showData[index]['fields']['name']) : SizedBox(),
                );
              },
            );
          }, future: DefaultAssetBundle.of(context).loadString("assets/services.json"),),
        ));
  }
}
