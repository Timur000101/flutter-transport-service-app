import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/request/request_cto_pagec.dart';
import 'package:sto_app/pages/request/request_wash_page.dart';

class RequestListItem extends StatelessWidget {
  final RequestItem request;
  String serviceText;
  String subserviceText;
  String orderImage;
  String orderAbout;

  RequestListItem(this.request);

  @override
  Widget build(BuildContext context) {
    serviceText = request.service['name'];
    if (request.subservice != null){
      subserviceText = request.subservice['name'];
      orderImage = request.orderImg[0]['image'];
      orderAbout = request.about;
    }
    else{
      subserviceText = '';
      orderImage = request.car.car_img[0]['image'];
      orderAbout = '';
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                          request.car.name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          request.car.year.toString(),
                          style: TextStyle(
                              fontSize: 16, color: AppColors.mainTextColor),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 3),
                    child: cornerImageView(orderImage),
                  ))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  chipRedText(serviceText),
                  chipRedText(subserviceText),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 2),
                    child: Text(orderAbout,
                        style: TextStyle(
                            fontSize: 13, color: AppColors.primaryTextColor)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: AppColors.primaryTextColor),
                            Text(
                              'Almaty',
                              style:
                                  TextStyle(color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0)),
                          onPressed: () {
                            if (subserviceText == ''){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestWashPage(request)),
                              );
                            }
                            else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestCtoPage(request)),
                              );
                            }
                            
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
  if (text == ''){
    return SizedBox(height:10);
  }
  else{
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
}

Widget cornerImageView(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(url,
        height: 90, alignment: Alignment.topCenter, fit: BoxFit.fitHeight),
  );
}
