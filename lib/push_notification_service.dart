// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class PushNotificationService extends StatefulWidget {

//   @override
//   _PushNotificationServiceState createState() => _PushNotificationServiceState();
// }

// class _PushNotificationServiceState extends State<PushNotificationService> {

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   @override
//   void initState() {
//     super.initState();
//     _getToken();

//     _configureFirebaseListeners();
//   }

//   String msg = "";
//   String tkn = "";
//   @override
//   Widget build(BuildContext context) {
//     print(tkn);
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Text(msg),
//             Text("asdasd"),
//             Text(tkn)
//           ],
//         ),
//       ),
//     );
//   }


//   _getToken() {
//     _firebaseMessaging.getToken().then((deviceToke) =>
//         tkn = deviceToke
//     );
//     print("Device token: $tkn");
//     setState(() {
//       tkn = tkn;
//     });

//   }

//   _configureFirebaseListeners() {
//     _firebaseMessaging.requestNotificationPermissions();
//     _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//           print("onMessage: $message");
//           setState(() {
//             this.msg = message.toString();
//           });
//           // _showItemDialog(message);
//         },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         setState(() {
//           this.msg = message.toString();
//         });
//         // _navigateToItemDetail(message);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         setState(() {
//           this.msg = message.toString();
//         });
//         // _navigateToItemDetail(message);
//       },
//     );
//   }
// }
