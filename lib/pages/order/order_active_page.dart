import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/active_order_customer.dart';
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


  List<ActiveOrderCustomer> activeListCustomer = [];
  List<ActiveOrderCustomer> activeListCto =[];

  getActiveCustomer() async {
    var token = await getToken();
    var parturl = AppConstants.role ? "order/active/1" : "order/active/0"  ;

    http.Response response =
        await http.get("${AppConstants.baseUrl}$parturl", headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    if (response.statusCode == 200) {
      setState(() {
        List<ActiveOrderCustomer> list = new List<ActiveOrderCustomer>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        // print(responseBody);
        for (Object i in responseBody){
          list.add(ActiveOrderCustomer.fromJson(i));
        }

        activeListCustomer= list;
      });
    } else {

      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load active order');
    }
  }

  getActiveCto() async {
    // var token = await getToken();
    // http.Response response =
    // await http.get("${AppConstants.baseUrl}order/active/", headers: {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   "Accept": "application/json",
    //   "Authorization": "Token $token"
    // });
    //
    // if (response.statusCode == 200) {
    //   ActiveOrder.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load historyorder');
    // }
  }

  @override
  void initState(){
    _refresh();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child:  ListView.builder(
            itemCount: activeListCustomer.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderActiveItem(active: activeListCustomer[index]);
            }),
        )
        );


  }

Widget projectWidget() {
  return FutureBuilder(
    builder: (context, projectSnap) {
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        //print('project snapshot data is: ${projectSnap.data}');
        return Container();
      }
      return ListView.builder(
      itemCount: activeListCustomer.length,
      itemBuilder: (BuildContext context, int index) {
      return OrderActiveItem(active: activeListCustomer[index]);
      });
    },
    future: getActiveCustomer(),
  );
}

  // ListView.builder(
  // itemCount: AppConstants.role ? activeListCto.length : activeListCustomer.length,
  // itemBuilder: (BuildContext context, int index) {
  // return OrderActiveItem(active:AppConstants.role ?  activeListCto[index] :  activeListCustomer[index]);
  // }),
  Future<Null> _refresh() async {
     await getActiveCustomer();
    return null;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }
}
