import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/models/brand.dart';
import 'package:sto_app/pages/profile/car_model_page.dart';


class CarBrandCard extends StatefulWidget {
  const CarBrandCard({
    Key key,
    @required this.index, 
    @required this.brand,
  }) : super(key: key);

  final int index;
  final Brand brand;

  @override
  _CarBrandCardState createState() => _CarBrandCardState();
}

class _CarBrandCardState extends State<CarBrandCard> {
  String brand = '';
  String model = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(widget.brand.name),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () async {
          brand = widget.brand.name;
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CarModelPage(brand: widget.brand,)),
          );
          model = result;
          if (model == null){
            Navigator.pop(context, 'Выберите марку машины');
          }
          else{
            Navigator.pop(context, '$brand, $model');
          }
        },
      ),
    );
  }
}
