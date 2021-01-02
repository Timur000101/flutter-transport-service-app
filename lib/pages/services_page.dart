import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Выберите услугу", 
          style: TextStyle(
            color: AppColors.mainTextColor,
            fontFamily: 'Montserrat SemiBold',
            fontSize: 18
          )
        ),
        backgroundColor: AppColors.backgroundColor,
        shadowColor: Colors.white,
        bottomOpacity: 1,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              primary: false,
              crossAxisCount: 2,
              children: <Widget>[
                _buildCard('assets/images/categories/cat_icon1.png', "СТО"),
                _buildCard('assets/images/categories/cat_icon2.png', "Кузовные работы"),
                _buildCard('assets/images/categories/cat_icon3.png', "Замена масла"),
                _buildCard('assets/images/categories/cat_icon4.png', "Автозапчасти"),
                _buildCard('assets/images/categories/cat_icon5.png', "Шиномонтаж"),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCard(imagePath, title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagePath, height: 70, width: 70,),
            SizedBox(height: 5,),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat Medium', 
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
