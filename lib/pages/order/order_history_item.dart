import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/order_history.dart';

class OrderHistoryItem extends StatelessWidget {
  final OrderHistory orderHistory;

  const OrderHistoryItem({Key key, this.orderHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.lightColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 1))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "7 янв. 2021г",
                    style: TextStyle(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: AppColors.primaryTextColor),
                      Text(
                        "Алматы",
                        style: TextStyle(color: AppColors.primaryTextColor),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Mercedes-Benz C55 AMG",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Ремонт ходовой/подвески ...",
                  style: TextStyle(color: AppColors.primaryTextColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      "СТО “Denso Service”",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "16500 KZT",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "Выполнено",
                      style: TextStyle(
                          color: false ? Colors.red : AppColors.greenColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
