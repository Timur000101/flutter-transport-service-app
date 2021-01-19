import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/request_page_detail.dart';

class RequestListItem extends StatelessWidget {
  final RequestItem request;

  RequestListItem(this.request);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: AppColors.lightColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 1))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        ),
                        Text(
                          request.year,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.mainTextColor),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: cornerImageView(request.urlImage))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  chipRedText(request.chipfirst),
                  chipRedText(request.chipSecond),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 2),
                    child: Text(request.description + request.description,
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primaryTextColor)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.primaryTextColor),
                            Text(
                              request.location,
                              style: TextStyle(color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestPageDetail()),
                            );
                          },
                          child: Text("Подробнее"),
                          color: Colors.green[700],
                          textColor: AppColors.lightColor,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget chipRedText(String text) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: AppColors.redColor),
    child: Text(
      text,
      style: TextStyle(color: AppColors.lightColor),
    ),
  );
}

Widget cornerImageView(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(url,
        width: 140,
        height: 125,
        alignment: Alignment.topCenter,
        fit: BoxFit.fill),
  );
}
