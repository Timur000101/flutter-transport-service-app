import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/order/orders_from_executor_page.dart';
import 'package:sto_app/pages/profile/profile_page.dart';
import 'package:sto_app/pages/request/request_page.dart';
import 'package:sto_app/pages/services/services_page.dart';
// import 'order/orders_from_executor_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [OrdersFromExecutorPage(), ServicesPage(), ProfilePage()];
  // OrdersFromExecutorPage()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.width * 0.14,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 15.0,
          iconSize: 17,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.primaryTextColor,
          selectedFontSize: 13,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Stoappicons.request_icon,
              ),
              label: "Заявки",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Stoappicons.services_icon,
              ),
              label: "Услуги",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Stoappicons.profile_icon,
              ),
              label: "Профиль",
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
