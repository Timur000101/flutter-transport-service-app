import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sto_app/components/carCard.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';


class MyCarsPage extends StatefulWidget {
    @override
    _MyCarsPageState createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage> {
    final List<Car> carList = [
        Car('Mersedec Benz C55 AMG1', 'год 2020', Image.network('https://a.d-cd.net/8bb322es-960.jpg')),
        Car('Mersedec Benz C55 AMG1', 'год 2020', Image.network('https://a.d-cd.net/8bb322es-960.jpg')),
        Car('Mersedec Benz C55 AMG1', 'год 2020', Image.network('https://a.d-cd.net/8bb322es-960.jpg')),
    ];
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: HexColor("#EDF2F4"),
            appBar: AppBar(
                title: Text(
                    'Мои автомобили',
                    style: TextStyle(color: Colors.black87),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
            ),
            body: Column(
              children: [
              Expanded(
                flex: 1,
                child: 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                  SizedBox.expand(
                        child:  RaisedButton( 
                            child: Text("Добавить машину", style: TextStyle(fontSize: 20),),  
                            onPressed: (){},
                            color: AppColors.mainColor,  
                            textColor: Colors.white,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ), 
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      itemCount: carList.length,
                      itemBuilder: (context, int index) => CarCard(car: carList[index], index: index,)
                    ),
                  ),
                ),
              ]
            )
        );
    }
}