import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/request/request_list_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<RequestItem> request_array = List<RequestItem>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // if (isRegister() == true){
    //   getOrders();
    // }
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: request_array.length,
          itemBuilder: (BuildContext context, int index) {
            return RequestListItem(request_array[index]);
          }),
      )
    );
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  Future<Null> _refresh() async {
    // await Future.delayed(Duration(seconds: 2));
    await getOrders();
    return null;
  }

  getOrders() async {
    var token = await getToken();
    await http.get(
      "${AppConstants.baseUrl}order/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        List<RequestItem> list = List<RequestItem>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        for (Object i in responseBody){
          list.add(RequestItem.fromJson(i));
        }
        setState(() {
          request_array = list;
        });
      }).catchError((error) => print(error));
  }

  isRegister() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var isReg = sharedPreferences.getBool(AppConstants.isReg);
    return isReg;
  }
}
