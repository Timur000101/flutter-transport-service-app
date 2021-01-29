import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';

Widget buildAppBar(String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(title,
          style: TextStyle(
              color: AppColors.mainTextColor,
              fontFamily: 'Montserrat Regular',
              fontSize: 18)),
      brightness: Brightness.light,
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.backgroundColor,
      shadowColor: Colors.white,
      bottomOpacity: 1,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );
}
