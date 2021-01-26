
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/order.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({
    Key key,
    @required this.order,
    @required this.index,
  }) : super(key: key);

  final Order order;
  final int index;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isSelected = true;

  @override
  void initState() {
    super.initState();
    print("Inite State!");
  }
  @override
  Widget build(BuildContext context) {
    print("Biuld!");
        return new Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 20,
                  shadowColor: Colors.black54,
                    color: _isSelected ? Colors.white : HexColor("D4FFD0"),
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
                                            children: [
                                            Text(widget.order.carName, style: new TextStyle(fontSize: 18)),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: Text(widget.order.problemTitle),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: HexColor("35953E"),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                                                child: Text(widget.order.stoName, style: TextStyle(color: Colors.white),),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0, left: 10),
                                              child: Row(
                                              children: <Widget>[
                                                  Icon(Stoappicons.distance, color: AppColors.primaryTextColor,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text(widget.order.range, style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),),
                                                  ),
                                                  Spacer(),
                                              ],
                                        ),
                                            )
                                          ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(children: [
                                                Icon(Icons.location_on, color: AppColors.primaryTextColor,),
                                                Text(widget.order.city),
                                              ],),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                child: Text(widget.order.cost, style: new TextStyle(fontSize: 18)),
                                              ),
                                              Text(widget.order.duration, style: new TextStyle(fontSize: 18)),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 45.0, right: 10.0),
                                                child: FlatButton(
                                                  child: Text('Отклонить', style: TextStyle(color: Colors.white),),
                                                  color: AppColors.mainColor,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isSelected = ! _isSelected;
                                                    });
                                                  },
                                                ),
                                              ),
                                              ]
                                          )
                                        ),
                                      )
                                  ],
                              ),
                          ],
                      ),
                    ),
                ),
              ),
            )
        );
    }
}