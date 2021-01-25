import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/services.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServiceDetail extends StatefulWidget {
  final List<Services> service;
  final int indx;

  ServiceDetail({this.indx, this.service});
  @override
  _ServiceDetailState createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Выберите категорию"),
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/services.json"),
                builder: (context, snapshot) {
                  List<Services> services = parseJson(snapshot.data.toString());
                  return ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return services[index].fields.service ==
                              widget.indx.toString()
                          ? Container(
                              child: CheckboxListTile(
                                dense: true,
                                title: Text(services[index].fields.name),
                                controlAffinity: ListTileControlAffinity.leading,
                                value: services[index].checked,
                                onChanged: (bool value) {
                                  setState(() {
                                    services[index].checked = value;
                                  });
                                },
                              ))
                          : SizedBox();
                    },
                  );
                },
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: AppColors.primaryTextColor)),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  textColor: Colors.white,
                  color: AppColors.primaryTextColor,
                  elevation: 3.0,
                  child: Text(
                    "Продолжить",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Services> parseJson(String response) {
    if (response == null) {
      return [];
    }
    List<dynamic> parsed = jsonDecode(response.toString());
    return parsed.map<Services>((json) => Services.fromJson(json)).toList();
  }
}
