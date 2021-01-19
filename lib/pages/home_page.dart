import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/profile_page.dart';
import 'package:sto_app/pages/request_page.dart';
import 'package:sto_app/pages/services_page.dart';

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
            icon: Icon(Stoappicons.request_icon),
            label: "Заявки",
          ),
          BottomNavigationBarItem(
            icon: Icon(Stoappicons.services_icon),
            label: "Услуги",
          ),
          BottomNavigationBarItem(
            icon: Icon(Stoappicons.profile_icon),
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
