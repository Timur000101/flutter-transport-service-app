import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServiceFinish extends StatefulWidget {
  ServiceFinish({Key key}) : super(key: key);

  @override
  _ServiceFinishState createState() => _ServiceFinishState();
}

class _ServiceFinishState extends State<ServiceFinish> {
  Object _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Finish"),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Выбирите машину", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.lightColor,
                    border: Border.all(color: AppColors.primaryTextColor)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: AppColors.lightColor,
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("First Item"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("Second Item"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("Third Item"),
                          value: 3
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      }
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Опишите проблему", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),),
                Container(
                  height: 6 * 25.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryTextColor,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(2, 3)
                      )
                    ]
                  ),
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: AppColors.lightColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0)
                      
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                  ),
                )
              ],
            ),
            SizedBox(height: 15.0,),
            Column(
              children: <Widget>[
                Text("Добавить фото", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryTextColor),),
              ],
            )
          ],
        ),
      )
    );
  }
}
