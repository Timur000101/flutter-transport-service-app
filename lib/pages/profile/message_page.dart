import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/models/message.dart';
import 'package:sto_app/pages/profile/message_item.dart';
import "package:sto_app/widgets/app_widgets.dart";
import 'package:sto_app/core/const.dart';
import 'package:http/http.dart' as http;

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<Message> messages = [];

  getMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString(AppConstants.key);

    var url = "${AppConstants.baseUrl}users/my/message/";
    final response = await http.get(url, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    if  (response.statusCode == 200) {
      List<Message> list = List<Message>();
      var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
      for (Object i in responseBody) {
        list.add(Message.fromJson(i));
      }
      if (mounted){
        setState(() {
          messages = list;
        });
      }
    }
    else {
       throw ("failed get message");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Сообщения"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder (
            itemCount: messages.length,
           itemBuilder: (BuildContext context, int index) {
              return MessageItem(messages[index]);
            }
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    // await Future.delayed(Duration(seconds: 2));
    getMessage();
    return null;
  }
}
// ListView.builder(
// itemCount: name.length,
// itemBuilder: (BuildContext context, int index) {
// return OrderHistoryItem(orderHistory: name[index]);
// }),