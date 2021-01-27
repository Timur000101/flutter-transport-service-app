import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/pages/create_identifier.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:sto_app/core/const.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RequestDetailPage extends StatefulWidget {
  @override
  _RequestDetailPageState createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  CarouselSlider carouselSlider;
  final priceController = TextEditingController();
  final timeController = TextEditingController();

  int _current = 0;
  List imgList = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1543922596-b3bbaba80649?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1502943693086-33b5b1cfdf2f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              carouselSlider = CarouselSlider(
                height: 160.0,
                initialPage: 0,
                enlargeCenterPage: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
                items: imgList.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTextColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(imgList, (index, url) {
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Colors.redAccent
                          : AppColors.primaryTextColor,
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "Mercedez-Benz C55 AMG",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Text("Ремонт ходовой/подвески/геометрия",
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 16,
                  )),
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryTextColor)),
                child: Text(
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Предложите свою цену:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.mainTextColor),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: myTextField(
                        priceController,
                        "Цена",
                        Icon(
                          Icons.ac_unit_rounded,
                          color: AppColors.primaryTextColor,
                        ),
                        "KZT",
                        TextInputType.number)),
                Text(
                  "Примерное время ремонта:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: myTextField(
                        timeController,
                        "Время",
                        Icon(
                          Icons.access_time_outlined,
                          color: AppColors.primaryTextColor,
                        ),
                        "",
                        TextInputType.text)),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0)),
                      child: Text(
                        "Посмотреть машину",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.red[600],
                      textColor: AppColors.lightColor,
                      onPressed: () {
                        print(timeController.text);
                        // Scaffold.of(context)
                        // .showSnackBar(SnackBar(content: Text('asdasd')));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(6.0)),
                      child: Text(
                        "Принять",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.green[700],
                      textColor: AppColors.lightColor,
                      onPressed: () {
                        print(priceController.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateIdentifier()),);
                        // Scaffold.of(context).showSnackBar(
                        // SnackBar(content: Text(timeController.text)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  final OutlineInputBorder myEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: AppColors.primaryTextColor,
    ),
  );
  final OutlineInputBorder myFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: AppColors.primaryTextColor),
  );

  Widget myTextField(TextEditingController contoller, String hintText,
      Icon icon, String suffixText, TextInputType textInputType) {
    return TextField(
        keyboardType: textInputType,
        controller: contoller,
        cursorColor: AppColors.primaryTextColor,
        decoration: InputDecoration(
          suffixText: suffixText,
          prefixIcon: icon,
          hintText: hintText,
          filled: true,
          fillColor: AppColors.lightColor,
          enabledBorder: myEnabledBorder,
          focusedBorder: myFocusedBorder,
        ));
  }

  // goToPrevious() {
  //   carouselSlider.previousPage(
  //       duration: Duration(milliseconds: 300), curve: Curves.ease);
  // }

  // goToNext() {
  //   carouselSlider.nextPage(
  //       duration: Duration(milliseconds: 300), curve: Curves.decelerate);
  // }
}
