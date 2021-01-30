// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/request/request_list_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final List<RequestItem> name = <RequestItem>[
    RequestItem(
        name: "Mercedes Benz C55 AMG",
        chipfirst: "CTO",
        chipSecond: "Ремонт ходовой/подвески...",
        year: "2017г (1,5л)",
        location: "Almaty",
        description:
            "Contrary to popular belief, Lorem Ipsum is not simply random text ...",
        urlImage:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/bugatti-chiron-pur-sport-106-1582836604.jpg"),
    RequestItem(
        name: "Mercedes Benz C55 AMG",
        chipfirst: "CTO",
        chipSecond: "Ремонт ходовой/подвески...",
        year: "2017г (1,5л)",
        location: "Almaty",
        description:
            "Contrary to popular belief, Lorem Ipsum is not simply random text ...",
        urlImage:
            "https://cdn.luxe.digital/media/2020/04/30200414/best-electric-cars-luxury-tesla-model-x-luxe-digital.jpg"),
    RequestItem(
        name: "Mercedes Benz C55 AMG",
        chipfirst: "CTO",
        chipSecond: "Ремонт ходовой/подвески...",
        year: "2017г (1,5л)",
        location: "Almaty",
        description:
            "Contrary to popular belief, Lorem Ipsum is not simply random text ...",
        urlImage: "https://pngimg.com/uploads/ferrari/ferrari_PNG10679.png"),
    RequestItem(
        name: "Mercedes Benz C55 AMG",
        chipfirst: "CTO",
        chipSecond: "Ремонт ходовой/подвески...",
        year: "2017г (1,5л)",
        location: "Almaty",
        description:
            "Contrary to popular belief, Lorem Ipsum is not simply random text ...",
        urlImage: "https://pngimg.com/uploads/ferrari/ferrari_PNG10679.png"),
    RequestItem(
        name: "Mercedes Benz C55 AMG",
        chipfirst: "CTO",
        chipSecond: "Ремонт ходовой/подвески...",
        year: "2017г (1,5л)",
        location: "Almaty",
        description:
            "Contrary to popular belief, Lorem Ipsum is not simply random text ...",
        urlImage: "https://pngimg.com/uploads/ferrari/ferrari_PNG10679.png")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return RequestListItem(name[index]);
          }),
    );
  }
}
