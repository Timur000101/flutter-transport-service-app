import 'package:flutter/material.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: buildAppBar("Добавить машину"),
       ),
    );
  }
}