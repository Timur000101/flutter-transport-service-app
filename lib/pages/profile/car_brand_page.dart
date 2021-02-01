import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/components/mainBrandCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/brand.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class CarBrandPage extends StatefulWidget {
  final List<Brand> brands = List<Brand>();
  @override
  _CarBrandPageState createState() => _CarBrandPageState();
}

class _CarBrandPageState extends State<CarBrandPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: buildAppBar("Выберите марку"),
         body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          child: Column(
            children: [
              Expanded(
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context).loadString("assets/cars_model.json"),
                builder: (context, snapshot) {
                  createArray();
                  return ListView.builder(
                    itemCount: widget.brands.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            color: AppColors.lightColor,
                            borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: MainBrandCard(
                          index: index,
                          brand: widget.brands[index],
                        )
                      );
                    },
                  );
                },
              )
            )
            ],
          )
        ))
       ),
    );
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/cars_model.json');
  }

  Future createArray() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    for (var i in jsonResponse){
      if (i['model'] == 'categories.brand'){
        widget.brands.add(Brand(i['fields']['name'], i['pk'].toString()));
      }
    }
  }
}

