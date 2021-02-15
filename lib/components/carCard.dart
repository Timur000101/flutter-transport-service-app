import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/pages/profile/my_cars_page.dart';

class CarCard extends StatefulWidget {
  const CarCard({
    Key key,
    @required this.car,
    @required this.index,
    @required this.callback,
  }) : super(key: key);

  final Car car;
  final int index;
  final Function callback;

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20,
            shadowColor: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.car.name, style: new TextStyle(fontSize: 18)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Text("год ${widget.car.year}", style: TextStyle(fontSize: 16, color: Colors.black54),),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: RaisedButton( 
                                            child: Text("Удалить", style: TextStyle(fontSize: 14),),  
                                            onPressed: (){deleteCar(widget.car.id);},
                                            color: AppColors.mainColor,  
                                            textColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5,10,5,5),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: Column(children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Container(
                                            color: Colors.blue,
                                            child: Image.network(
                                              widget.car.car_img[0]['image'],
                                              fit: BoxFit.fitHeight,
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              height: 100,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                        ),
                    ],
                ),
              ),
          ),
        ),
      )
    );
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  deleteCar(int id) async {
    var token = await getToken();
    final url = Uri.parse(AppConstants.baseUrl + "cars/");
    final request = await http.Request('DELETE', url);
    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    });
    request.body = jsonEncode(<String, int>{
      'id': id,
    });
    final response = await request.send();
    if (response.statusCode == 200) {
      print(response.statusCode);
      widget.callback();
    } else {
      print("Error");
    }
  }

  
}