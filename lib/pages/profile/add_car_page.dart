import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';

import 'car_brand_page.dart';

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  List<Image> img_array = [Image.asset('assets/images/Add_photo_placeholder.png', height: 100, width: 100,fit: BoxFit.fitHeight)];
  final globalKey = GlobalKey<ScaffoldState>();
  var _carBrand = 'Выберите марку машины';
  var brandTextField = TextEditingController();
  var yearTextField = TextEditingController();
  var volumeTextField = TextEditingController();
  var mileageTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        key: globalKey,
        appBar: buildAppBar("Добавить машину"),
        body:  GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
              height: 600,
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
                      controller: brandTextField,
                      showCursor: false,
                      onChanged: (text) {
                        brandTextField.text = _carBrand;
                      },
                      onTap: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CarBrandPage()),
                        );
                        brandTextField.text = result;
                        _carBrand = result;
                      },
                      style: TextStyle(fontSize: 16.0, color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
                      decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Stoappicons.car_model, color: Colors.black),
                        hintText: _carBrand,
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
                      controller: yearTextField,
                      keyboardType: TextInputType.number,
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
                      controller: volumeTextField,
                      // keyboardType: TextInputType.,
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
                      controller: mileageTextField,
                      keyboardType: TextInputType.number,
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
                                  child: img_array[index],
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
                                  child: img_array[index],
                                )
                            );
                          }
                        }
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,10,15,20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: (){
                          _addCar();
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
          ]
        )
        )
        )
      ),
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
          img_array.insert(0,Image.file(image, height: 100, width: 100, fit: BoxFit.fitHeight));
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

  _addCar(){
    if (_carBrand != 'Выберите марку машины'){
      if (int.tryParse(yearTextField.text) != null && (int.tryParse(yearTextField.text) < 2030 || int.tryParse(yearTextField.text) > 1980)){
        if (double.tryParse(volumeTextField.text) != null && (double.tryParse(volumeTextField.text) < 12.0 && double.tryParse(volumeTextField.text) > 0.5)){
          if (double.tryParse(mileageTextField.text) != null && (int.tryParse(mileageTextField.text) > 0 && int.tryParse(mileageTextField.text) < 3000000)){
            _sendCarInfo();
          }
          else{
            final snackBar = SnackBar(content: Text('Введите корректный км. пробега.'));
            globalKey.currentState.showSnackBar(snackBar);
          }
        }
        else{
          final snackBar = SnackBar(content: Text('Введите корректный объем.'));
          globalKey.currentState.showSnackBar(snackBar);
        }
      }
      else{
        final snackBar = SnackBar(content: Text('Введите корректный год.'));
        globalKey.currentState.showSnackBar(snackBar);
      }
    }
    else{
      final snackBar = SnackBar(content: Text('Выберите марку машины.'));
      globalKey.currentState.showSnackBar(snackBar);
    }
  }


  _sendCarInfo(){
    print(brandTextField.text);
  }
}