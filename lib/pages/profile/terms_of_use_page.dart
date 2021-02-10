import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class TermsOfUsePage extends StatefulWidget {
  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  String text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("О приложении"),
      body: Container(
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Stack(children: <Widget>[
                Text(text*4, style: TextStyle(fontSize: 14),),
              ]
            )
          )
        ),
      )
    );
  }
}