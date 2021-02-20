import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/active_order.dart';
import 'package:sto_app/models/order_history.dart';
import 'package:sto_app/pages/order/order_active_item.dart';
import 'package:http/http.dart' as http;

class OrderActivePage extends StatefulWidget {
  OrderActivePage({Key key}) : super(key: key);

  @override
  _OrderActivePageState createState() => _OrderActivePageState();
}

class _OrderActivePageState extends State<OrderActivePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  getactive() async {
    var token = await getToken();
    http.Response response =
        await http.get("${AppConstants.baseUrl}order/active/", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
       ActiveOrder.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load historyorder');
    }
  }

  List<ActiveOrder> activeList;

  @override
  void initState() {
   getactive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: buildAppBar("История заказов"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
            itemCount: activeList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderActiveItem(active: activeList[index]);
            }),
      ),
    );
  }

  Future<Null> _refresh() async {
    await getactive();
    return null;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }
}
