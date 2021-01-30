import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/components/mainBrandCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/brands.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class CarBrandPage extends StatefulWidget {
  @override
  _CarBrandPageState createState() => _CarBrandPageState();
}

class _CarBrandPageState extends State<CarBrandPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: buildAppBar("Выберите марку"),
         body: Expanded(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString("assets/cars_model.json"),
            builder: (context, snapshot) {
            List<Brands> brands = parseJson(snapshot.data.toString());
            return ListView.builder(
              itemCount: brands.length,
              itemBuilder: (BuildContext context, int index) {
                return brands[index].fields.brand == index.toString()
                ? Container(
                  margin:
                      EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      color: AppColors.lightColor,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: MainBrandCard(
                    index: index,
                    brands: brands[index],
                  )
                ) : SizedBox();
              },
            );
          },
        ))
       ),
    );
  }

  List<Brands> parseJson(String response) {
    if (response == null) {
      return [];
    }
    List<dynamic> parsed = jsonDecode(response.toString());
    return parsed.map<Brands>((json) => Brands.fromJson(json)).toList();
  }
}

