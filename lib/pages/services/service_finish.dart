import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class ServiceFinish extends StatefulWidget {
  final int servicePK;
  ServiceFinish({this.servicePK});

  @override
  _ServiceFinishState createState() => _ServiceFinishState();
}

class _ServiceFinishState extends State<ServiceFinish> {
  List<File> img_array = [File('assets/images/Add_photo_placeholder.png')];
  final globalKey = GlobalKey<ScaffoldState>();
  Object _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Подробнее"),
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 5, 5),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: img_array.length,
                  itemBuilder: (context, int index) {
                    if (index == img_array.length-1){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: (){
                              _imgFromGallery();
                            },
                            child: Image.asset(img_array[index].path, height: 100, width: 100, fit: BoxFit.fitHeight,)
                          )
                      );
                    }
                    else{
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: (){
                              _deleteImage(index);
                            },
                            child:  Image.asset(img_array[index].path, height: 100, width: 100, fit: BoxFit.fitHeight,)
                          )
                      );
                    }
                  }
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: (){
                    _createOrder();
                    },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.red)),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  textColor: Colors.white,
                  color: AppColors.mainColor,
                  elevation: 3.0,
                  child: Text(
                    "Создать",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  _imgFromGallery() async {
    if (img_array.length == 6){
      final snackBar = SnackBar(content: Text("Не более 5-ти фотографии."));
      globalKey.currentState.showSnackBar(snackBar);
    }
    else{
      File image = await  ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50
      );

      setState(() {
        if (image==null) {
        } 
        else{
          img_array.insert(0, image);
        }
      });
    }
  }

  _deleteImage(int index) {
    setState((){
      img_array.removeAt(index);
      final snackBar = SnackBar(content: Text("Фотография удалена."));
      globalKey.currentState.showSnackBar(snackBar);
    });
  }


  _createOrder(){
    print("Create!");
  }
}
