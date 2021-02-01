import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/components/carModelCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/brand.dart';
import 'package:sto_app/models/model.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class CarModelPage extends StatefulWidget {
  final List<Model> models = List<Model>();
  final Brand brand;
  CarModelPage({
    Key key, 
    @required this.brand
  }) : super(key: key);
  @override
  _CarModelPageState createState() => _CarModelPageState();
}

class _CarModelPageState extends State<CarModelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: buildAppBar("Выберите модель"),
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
                      itemCount: widget.models.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin:
                              EdgeInsets.only(right: 10.0, left: 10.0, bottom: 5.0),
                          decoration: BoxDecoration(
                              color: AppColors.lightColor,
                              borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: CarModelCard(
                            index: index,
                            model: widget.models[index],
                          )
                        );
                      },
                    );
                  },
                )
              )
              ],
            )
          )
        )
      )
    );
  }


  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/cars_model.json');
  }

  Future createArray() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    for (var i in jsonResponse){
      if (i['model'] == 'categories.model'){
        if (i['fields']['brand'].toString() == widget.brand.pk){
          widget.models.add(Model(i['fields']['name'], i['fields']['brand'].toString()));
        }
      }
    }
  }
}