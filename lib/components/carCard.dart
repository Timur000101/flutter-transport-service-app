
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';

class CarCard extends StatefulWidget {
  const CarCard({
    Key key,
    @required this.car,
    @required this.index,
  }) : super(key: key);

  final Car car;
  final int index;

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20,
            shadowColor: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.car.carName, style: new TextStyle(fontSize: 18)),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Text(widget.car.year, style: TextStyle(fontSize: 16, color: Colors.black54),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: Column(children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Container(
                                            color: Colors.blue,
                                            child: Image.network(
                                              widget.car.photo, 
                                              fit: BoxFit.fitHeight,
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              height: 90,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(children: [
                            SizedBox(
                              width: 120,
                              child: RaisedButton( 
                                child: Text("Изменить", style: TextStyle(fontSize: 14),),  
                                onPressed: (){},
                                color: AppColors.primaryColor,  
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 120,
                              child: RaisedButton( 
                                child: Text("Удалить", style: TextStyle(fontSize: 14),),  
                                onPressed: (){},
                                color: AppColors.mainColor,  
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],),
                        )
                    ],
                ),
              ),
          ),
        ),
      )
    );
  }
}