import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/components/orderCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/utils/alert.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import '../../models/order.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
// import 'package:app_settings/app_settings.dart';

class OrdersFromExecutorPage extends StatefulWidget {
  @override
  _OrdersFromExecutorPageState createState() => _OrdersFromExecutorPageState();
}

class _OrdersFromExecutorPageState extends State<OrdersFromExecutorPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<Order> orderList = [];

  @override
  void initState() {
    super.initState();
    _getCurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#EDF2F4"),
        appBar: buildAppBar("Заявки"),
        body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: Container(
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, int index) => OrderCard(
                        order: orderList[index],
                        index: index,
                        callback: _getCurrentlocation,
                      )),
            )));
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    _getCurrentlocation();
    return null;
  }

  getOrders(String lat, String lng) async {
    // print("lat : $lat");
    // print("lng : $lng");
    var token = await getToken();
    // var queryParams = {'lat':  lat, 'lng': lng};

    // Map<String, dynamic> queryParameters = {
    //   'lat':  lat, 'lng': lng
    // };
    //
    // var uri = Uri.https("back.bumper-app.kz", "order/request/", queryParameters);
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": "Token $token"
    };


    await http.get(AppConstants.baseUrl+"order/request/$lat/$lng", headers: headers,  ).then((response) {
      // print("asdkalsdjalkdjaksdjkaksdjaksd");
      // print(response.body);
      List<Order> list = List<Order>();
      var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
      for (Object i in responseBody) {
        list.add(Order.fromJson(i));
      }
      if (mounted) {
        setState(() {
          orderList = list;
        });
      }
    }).catchError((error) => print(error));
  }

  _getCurrentlocation() async {
    Location location = new Location();
    // location.changeSettings(accuracy: LocationAccuracy.high,interval: 1000, distanceFilter: 0 );

    bool _serviceEnabled = false;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        if (Platform.isAndroid) {
          showCustomAlert();
        }
      }
      return;
    } else {
      _locationData = await location.getLocation();
      // if (AppConstants.isreg) {
        getOrders(_locationData.latitude.toString(),
            _locationData.longitude.toString());
      // }
      return;
    }
  }

  showCustomAlert() {
    var dialog = CustomAlertDialog(
        title: "Внимание",
        message: "Чтобы приложение работала корректно нужно дать разрешения ",
        onPostivePressed: () {
          Navigator.pop(context);
          // AppSettings.openAppSettings();
        },
        positiveBtnText: 'Ок',
        negativeBtnText: 'Нет');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
