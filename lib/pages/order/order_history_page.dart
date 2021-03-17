import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/active_order_customer.dart';
import 'package:sto_app/models/order_history.dart';
import 'package:sto_app/pages/order/order_history_item.dart';
import "package:sto_app/widgets/app_widgets.dart";
import 'package:http/http.dart' as http;

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  gethistory() async {
    var token = await getToken();
    var parturl = AppConstants.role ? "order/history/1" : "order/history/0"  ;
    http.Response response =
        await http.get("${AppConstants.baseUrl}$parturl", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      if (mounted) {
      setState(() {
        List<ActiveOrderCustomer> list = new List<ActiveOrderCustomer>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        for (Object i in responseBody) {
          list.add(ActiveOrderCustomer.fromJson(i));
        }
        historyList = list;
      });
      }
      } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load historyorder');
    }
  }

  List<ActiveOrderCustomer> historyList = <ActiveOrderCustomer>[];


  @override
  void initState() {
    _refresh();
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
            itemCount: historyList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderHistoryItem(orderHistory: historyList[index]);
            }),
      ),
    );
  }

  Future<Null> _refresh() async {
    await gethistory();
    return null;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  // getHistory() async {
  //   var token = await getToken();
  //   await Dio().get(
  //     "${AppConstants.baseUrl}order/history/",
  //     options: Options(
  //         headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "Accept": "application/json",
  //         "Authorization": "Token $token"
  //       },
  //       followRedirects: false,
  //       validateStatus: (status) {
  //         return status < 500;
  //       },
  //     ),
  //     ).then((response) {
  //       print(response);
  //     }).catchError((error) => print(error));
  // }
}
