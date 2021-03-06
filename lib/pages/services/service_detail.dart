import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/components/service_detail_item.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/services.dart';
import 'package:sto_app/pages/services/service_finish.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServiceDetail extends StatefulWidget {
  final List<Services> service;
  final int indx;

  ServiceDetail({this.indx, this.service});
  @override
  _ServiceDetailState createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
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
                              margin: EdgeInsets.only(
                                  right: 10.0, left: 10.0, bottom: 5.0),
                              decoration: BoxDecoration(
                                  color: AppColors.lightColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              child: ServiceDetailItem(
                                index: index,
                                services: services[index],
                              ))
                          : SizedBox();
                    },
                  );
                },
              )),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //   child: RaisedButton(
              //     onPressed: () async {
              //       SharedPreferences prefs = await SharedPreferences.getInstance();
              //       var subIndex = prefs.getInt('SubservicePK');
              //       Navigator.push(context, MaterialPageRoute(
              //         builder: (context) => ServiceFinish(servicePK: widget.indx, subservicePK: subIndex,))
              //       );
              //     },
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //         side: BorderSide(color: AppColors.primaryTextColor)),
              //     padding: const EdgeInsets.symmetric(vertical: 20.0),
              //     textColor: Colors.white,
              //     color: AppColors.primaryTextColor,
              //     elevation: 3.0,
              //     child: Text(
              //       "Продолжить",
              //       style: TextStyle(
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
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
