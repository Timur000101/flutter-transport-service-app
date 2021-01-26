import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';

Widget buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(title,
        style: TextStyle(
          color: AppColors.mainTextColor,
          fontFamily: 'Montserrat Semibold',
          fontSize: 18
          )
      ),
      brightness: Brightness.light,
      backgroundColor: AppColors.backgroundColor,
      shadowColor: Colors.white,
      bottomOpacity: 1,
    );
  }