import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/order/order_active_page.dart';
import 'package:sto_app/pages/order/order_history_page.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text("Заказы",
                  style: TextStyle(
                      color: AppColors.mainTextColor,
                      fontFamily: 'Montserrat Regular',
                      fontSize: 18)),
              brightness: Brightness.light,
              automaticallyImplyLeading: true,
              backgroundColor: AppColors.backgroundColor,
              shadowColor: Colors.white,
              bottomOpacity: 1,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            bottom:
            TabBar(
              labelColor:AppColors.primaryTextColor ,
                tabs: [
                  Tab(text: "Активные заказы", ),
                  Tab(text:  "История заказов"),

                ])
            // preferredSize: Size.fromHeight(kToolbarHeight),
            // child: new Container(
            //   color: AppColors.backgroundColor,
            //   child: new SafeArea(
            //     child: Column(
            //       children: <Widget>[
            //         new Expanded(child: new Container()),
            //         new TabBar(
            //           labelColor: AppColors.primaryTextColor,
            //           tabs: [
            //             Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 15.0),
            //               child: new Text(
            //                 "Активные заказы",
            //                 style: TextStyle(fontSize: 15),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(vertical: 15.0),
            //               child: new Text(
            //                 "История заказов",
            //                 style: TextStyle(fontSize: 15),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          body: new TabBarView(
            children: <Widget>[
              OrderActivePage(),
              OrderHistoryPage(),
            ],
          ),
        ),
    );

  }
}
