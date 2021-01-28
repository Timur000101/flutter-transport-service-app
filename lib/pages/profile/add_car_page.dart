import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {

  Image _image = Image.asset('assets/images/Add_photo_placeholder.png', height: 100, width: 100,);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: buildAppBar("Добавить машину"),
        body:  Container(
          color: AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextField(
                  style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Stoappicons.car_model, color: Colors.black),
                    hintText: "Выберите марку машины",
                    enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextField(
                  style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Stoappicons.calendar, color: Colors.black),
                    hintText: "Год машины",
                    enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextField(
                  style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Stoappicons.engine_volume, color: Colors.black),
                    hintText: "Объем двигателя (л)",
                    enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,10,15,5),
                child: TextField(
                  style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Stoappicons.raphael_roadmap, color: Colors.black),
                    hintText: "Пробег (км)",
                    enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 10, 10),
                child: Text('Добавить фото', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 5, 5),
                child: Material(
                  child: InkWell(
                    onTap: (){
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    },
                    child: _image,
                  )
                )
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0,10,15,20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                      
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.red)),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    textColor: Colors.white,
                    color: AppColors.mainColor,
                    elevation: 3.0,
                    child: Text(
                      "Добавить",
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
      ),
    );
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = Image.file(image, height: 100, width: 100,);
    });
  }
}