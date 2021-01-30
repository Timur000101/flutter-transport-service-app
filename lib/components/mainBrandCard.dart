import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/models/brands.dart';

class MainBrandCard extends StatefulWidget {
  const MainBrandCard({
    Key key,
    @required this.index, 
    @required this.brands,
  }) : super(key: key);

  final int index;
  final Brands brands;

  @override
  _MainBrandCardState createState() => _MainBrandCardState();
}

class _MainBrandCardState extends State<MainBrandCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(widget.brands.fields.name),
      ),
    );
  }
}
