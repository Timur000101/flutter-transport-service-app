import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/components/carCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/utils/internet_manager.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;
import 'add_car_page.dart';

class MyCarsPage extends StatefulWidget {
  @override
  _MyCarsPageState createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage> {
  List<Car> carList = new List<Car>();

  // bool isEmpty = true;

  @override
  void initState() {
    checkInternetConnection().then((value) => {
      if (value){
        getCars()
      }
      else{
        showAlert("Внимание", "У вас нет соединения с интернетом!", context)
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#EDF2F4"),
        appBar: buildAppBar("Мои автомобили"),
        body: Column(children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox.expand(
                  child: RaisedButton(
                    child: Text(
                      "Добавить автомобиль",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddCarPage()),
                      ).whenComplete(() => {getCars()});
                    },
                    color: AppColors.mainColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                  itemCount: carList.length,
                  itemBuilder: (context, int index) => CarCard(
                        car: carList[index],
                        index: index,
                        callback: getCars
                      )),
            ),
          ),
        ]));
  }

  getCars() async {
    var token = await getToken();
    List<Car> list = await getMyCars(token);
    if(mounted){
      setState(() {
        carList = list;
      });
    }
  }
}

Future<List<Car>> getMyCars(String token) async {
  var url = "${AppConstants.baseUrl}${AppConstants.carsUrl}";
  final response = await http.get(url, headers: {
    "Content-type": "application/json",
    "Accept": "application/json",
    "Authorization": "Token $token"
  });
  if (response.statusCode == 200) {
    List<Car> carList = new List<Car>();
    var responseBody = jsonDecode(response.body);
    for (Object i in responseBody){
      carList.add(Car.fromJson(i));
    }
    return carList;
  } else {
    print("Error");
  }
}
