import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/profilePage/profile_page.dart';
import 'package:sto_app/pages/requestPage/request_page.dart';
import 'package:sto_app/pages/servicesPage/services_page.dart';
import 'package:sto_app/sto_icons_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [RequestPage(), ServicesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 15.0,
        iconSize: 25,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.primaryTextColor,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: Icon(StoIcons.request_icon),
            label: "Заявки",
          ),
          BottomNavigationBarItem(
            icon: Icon(StoIcons.services_icon),
            label: "Услуги",
          ),
          BottomNavigationBarItem(
            icon: Icon(StoIcons.profile_icon),
            label: "Профиль",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
