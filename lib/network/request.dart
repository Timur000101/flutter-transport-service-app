// import 'package:http/http.dart' as http;
// import 'package:sto_app/core/const.dart';
// import 'package:sto_app/models/sms_response.dart';
// import 'dart:convert';

// Future<SmsResponse> verification(String phone, String code) async {
//   final response = await http.post(AppConstants.baseUrl + "users/code/",
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{'phone': phone, 'code': code}));

//   if (response.statusCode == 200) {
//     return SmsResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception("Falied to registration");
//   }
// }

// Future<String> registration(String phone, String name) async {
//   final response = await http.post(AppConstants.baseUrl + "users/phone/",
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'phone': phone,
//         'nickname': name,
//       }));
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw Exception("Falied to registration");
//   }
// }
