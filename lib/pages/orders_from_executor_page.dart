import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sto_app/components/OrderCard.dart';
import '../models/order.dart';


class OrdersFromExecutorPage extends StatefulWidget {
    @override
    _OrdersFromExecutorPageState createState() => _OrdersFromExecutorPageState();
}

class _OrdersFromExecutorPageState extends State<OrdersFromExecutorPage> {
    final List<Order> orderList = [
        Order('Mersedec Benz C55 AMG1', 'Ремонт двигателя и кузовные работы', r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
        Order('Mersedec Benz C55 AMG2', 'Ремонт двигателя и кузовные работы', r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
        Order('Mersedec Benz C55 AMG3', 'Ремонт двигателя и кузовные работы', r'СТО "Denso Service"', '1 день', '15600 KZT', 'Алматы', '5 км'),
    ];
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: HexColor("#EDF2F4"),
            appBar: AppBar(
                title: Text(
                    'Заявки',
                    style: TextStyle(color: Colors.black87),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
            ),
            body: Container(
            child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, int index) => OrderCard(order: orderList[index], index: index,)
            ),
          )
        );
    }
}
