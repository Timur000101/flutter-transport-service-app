import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServiceDetail extends StatefulWidget {
  final int indx;

  ServiceDetail({this.indx});
  @override
  _ServiceDetailState createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  bool isSelected = false;
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
                  builder: (context, snapshot) {
                    var showData = json.decode(snapshot.data.toString());
                    return ListView.builder(
                      itemCount: showData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return showData[index]['fields']['service'] ==
                                widget.indx.toString()
                            ? Container(
                                margin: EdgeInsets.only(bottom: 3),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: CheckboxListTile(
                                  // value: s,
                                  title: new Text(showData[index]['fields']['name']),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged:(bool val){
                                    // ItemChange(val, index);
                                  }
                                )
                                // ListTile(
                                //   tileColor: Colors.white,
                                //   title: Text(showData[index]['fields']['name'], style: TextStyle(fontWeight: FontWeight.w500),),
                                //   trailing: Checkbox(
                                //     onChanged: () {},
                                //   ),
                                //   onTap: () {
                                //     setState(() {
                                //       isSelected = !isSelected;
                                //       print(isSelected);
                                //     });
                                //   },
                                // ),
                              )
                            : SizedBox();
                      },
                    );
                  },
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/services.json"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
