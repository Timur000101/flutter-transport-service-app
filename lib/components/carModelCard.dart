import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/models/brand.dart';
import 'package:sto_app/models/model.dart';
import 'package:sto_app/pages/profile/car_model_page.dart';


class CarModelCard extends StatefulWidget {
  const CarModelCard({
    Key key,
    @required this.index, 
    @required this.model,
  }) : super(key: key);

  final int index;
  final Model model;

  @override
  _CarModelCardState createState() => _CarModelCardState();
}

class _CarModelCardState extends State<CarModelCard> {
  String model = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(widget.model.name),
        onTap: () async {
          model = widget.model.name;
          Navigator.pop(context, model);
        },
      ),
    );
  }
}
