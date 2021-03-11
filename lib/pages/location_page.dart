// import 'dart:io';
// import 'package:sto_app/utils/alert.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// // import 'package:app_settings/app_settings.dart';
//
// class LocationPage extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Geo position",
//           style: TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         FlatButton(
//           onPressed: () async {
//             await _getCurrentlocation();
//           },
//           child: Text("get location"),
//           color: Colors.red,
//         )
//       ],
//     ));
//   }
//
//   _getCurrentlocation() async {
//     Location location = new Location();
//     // location.changeSettings(accuracy: LocationAccuracy.high,interval: 1000, distanceFilter: 0 );
//
//     bool _serviceEnabled = false;
//     PermissionStatus _permissionGranted;
//     LocationData _locationData;
//
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//        _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         if (Platform.isAndroid) {
//           showCustomAlert();
//         }
//       }
//       return;
//     } else {
//       _locationData = await location.getLocation();
//       print(_locationData.latitude);
//     }
//   }
//
//   showCustomAlert() {
//     var dialog = CustomAlertDialog(
//         title: "Внимание",
//         message: "Чтобы приложение работала корректно нужно дать разрешения ",
//         onPostivePressed: () {
//           Navigator.pop(context);
//           // AppSettings.openAppSettings();
//         },
//         positiveBtnText: 'Ок',
//         negativeBtnText: 'Нет');
//     showDialog(context: context, builder: (BuildContext context) => dialog);
//   }
// }
