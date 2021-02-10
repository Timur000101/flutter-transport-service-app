import 'package:flutter/material.dart';
import 'package:sto_app/models/message.dart';
import 'package:sto_app/pages/profile/message_item.dart';
import "package:sto_app/widgets/app_widgets.dart";
import 'package:sto_app/core/const.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  final List<Message> messages = [
    Message( word: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quaerat, ratione ..."),
    Message( word: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quaerat, ratione ..."),
    Message( word: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quaerat, ratione ...")
  ];



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
    await Future.delayed(Duration(seconds: 2));
    setState(() {

    });
    return null;
  }
}
// ListView.builder(
// itemCount: name.length,
// itemBuilder: (BuildContext context, int index) {
// return OrderHistoryItem(orderHistory: name[index]);
// }),