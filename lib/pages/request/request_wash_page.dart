import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';


class RequestWashPage extends StatefulWidget {



  @override
  _RequestWashPageState createState() => _RequestWashPageState();
}

class _RequestWashPageState extends State<RequestWashPage> {

  CarouselSlider carouselSlider;
  final globalKey = GlobalKey<ScaffoldState>();

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
  void initState() {
    super.initState();
    // for (var i in widget.request.orderImg) {
    //   imgList.add(i['image']);
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        backgroundColor: AppColors.backgroundColor,
        appBar: buildAppBar("Заявки"),
        body:  SingleChildScrollView(
            reverse: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[carouselSlider = CarouselSlider(
                    height: 160.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    // autoPlay: true,
                    reverse: false,
                    // enableInfiniteScroll: true,
                    // autoPlayInterval: Duration(seconds: 2),
                    // autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    // pauseAutoPlayOnTouch: Duration(seconds: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 4,right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTitle("Марка машины"),
                          getText("Toyota Camry",Stoappicons.car_model ),
                          getTitle("Год машины"),
                          getText("2015",Stoappicons.calendar),
                          getTitle("Объем двигателя (л)"),
                          getText("3.5",Stoappicons.engine_volume),
                          getTitle("Пробег (км)"),
                          getText("120000 км",Stoappicons.raphael_roadmap),
                        ],
                      ),
                    ),
                  ]
              ),
            ]),
          ),

    );
  }
  Widget getTitle(String title) {
    return  Padding(
        padding: const EdgeInsets.fromLTRB(15,5,0,0),
        child:Text(title, style: TextStyle(fontSize: 12),)
    );
  }

  Widget getText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,5,15,5),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(  borderRadius: BorderRadius.all(Radius.circular(10.0)), color: Colors.white )
          ,child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 13, 10, 13 ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, color: Colors.black),
            ),
            Text(text, style: TextStyle(color: Colors.black )),
          ],
        ),
      )),
    );
  }
}
