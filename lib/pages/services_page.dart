import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/service_detail.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Выберите услугу"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    var showData = json.decode(snapshot.data.toString());
                    return GridView.builder(
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return showData[index]['model'] == "services.service"
                              ? _buildCard(
                                  'assets/images/categories/cat_icon${index + 1}.png',
                                  showData[index]['fields']['name'],
                                  showData[index]['pk'])
                              : SizedBox();
                        });
                  }
                  return SizedBox();
                },
                future: DefaultAssetBundle.of(context)
                    .loadString("assets/services.json"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(imagePath, title, path) {
    return InkWell(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imagePath,
                  height: 60,
                  width: 60,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServiceDetail(
                        indx: path,
                      )));
        });
  }
}
