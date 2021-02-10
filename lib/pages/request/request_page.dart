import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/request_item.dart';
import 'package:sto_app/pages/request/request_list_item.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final List<RequestItem> name = List<RequestItem>();

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Заявки"),
      body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return RequestListItem(name[index]);
          }),
    );
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  getOrders() async {
    var token = await getToken();
    await http.get(
      "${AppConstants.baseUrl}order/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        print(response.body);
      }).catchError((error) => print(error));
  }
}
