import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/components/orderCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import '../../models/order.dart';
import 'package:http/http.dart' as http;

class OrdersFromExecutorPage extends StatefulWidget {
  @override
  _OrdersFromExecutorPageState createState() => _OrdersFromExecutorPageState();
}

class _OrdersFromExecutorPageState extends State<OrdersFromExecutorPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final List<Order> orderList = [
    Order('Mersedec Benz C55 AMG1', 'Ремонт двигателя и кузовные работы',
        r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
    Order('Mersedec Benz C55 AMG2', 'Ремонт двигателя и кузовные работы',
        r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
    Order('Mersedec Benz C55 AMG3', 'Ремонт двигателя и кузовные работы',
        r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
  ];

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#EDF2F4"),
        appBar: buildAppBar("Заказы"),
        body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Container(
          child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, int index) => OrderCard(
                    order: orderList[index],
                    index: index,
                    callback: getOrders,
                  )),
        )));
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    getOrders();
    return null;
  }

  getOrders() async {
    var token = await getToken();
    await http.get(
      "${AppConstants.baseUrl}order/request/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        print(response.body);
      }).catchError((error) => print(error));
  }
}
