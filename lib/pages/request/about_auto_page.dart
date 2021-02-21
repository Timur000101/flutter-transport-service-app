import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';


class AboutAutoPage extends StatefulWidget {
  final Car car;
  AboutAutoPage({this.car});
  @override
  _AboutAutoPageState createState() => _AboutAutoPageState();
}

class _AboutAutoPageState extends State<AboutAutoPage> {

  CarouselSlider carouselSlider;
  final globalKey = GlobalKey<ScaffoldState>();

  int _current = 0;
  List imgList = [];

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
    for (var i in widget.car.car_img) {
      imgList.add(i['image']);
    }
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
                                fit: BoxFit.fitWidth,
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
                          getText(widget.car.name, Stoappicons.car_model ),
                          getTitle("Год машины"),
                          getText(widget.car.year.toString(),Stoappicons.calendar),
                          getTitle("Объем двигателя (л)"),
                          getText(widget.car.size.toString() ,Stoappicons.engine_volume),
                          getTitle("Пробег (км)"),
                          getText("${widget.car.milage} км",Stoappicons.raphael_roadmap),
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
