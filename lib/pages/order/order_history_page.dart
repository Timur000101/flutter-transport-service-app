import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/order_history.dart';
import 'package:sto_app/pages/order/order_history_item.dart';
import "package:sto_app/widgets/app_widgets.dart";

class OrderHistoryPage extends StatefulWidget {
  OrderHistoryPage({Key key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final List<OrderHistory> name = <OrderHistory>[
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
    new OrderHistory(
        time: "7 янв. 2021г",
        location: "Алматы",
        carName: "Mercedes Benz C55 AMG",
        repairs: "Ремонт ходовой/подвески...",
        ctoName: "СТО “Denso Service”",
        price: "16500 KZT",
        isPerformed: "Выполнено"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("История заказов"),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderHistoryItem(orderHistory: name[index]);
            }),
      ),
    );
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      name.removeAt(0);
    });
    return null;
  }
}
