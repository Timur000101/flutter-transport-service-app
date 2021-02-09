import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;
import 'car_brand_page.dart';
import 'package:dio/dio.dart';

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  List<File> img_array = [File('assets/images/Add_photo_placeholder.png')];
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

  _addCar(){
    if (_carBrand != 'Выберите марку машины'){
      if (int.tryParse(yearTextField.text) != null && (int.tryParse(yearTextField.text) < 2030 || int.tryParse(yearTextField.text) > 1980)){
        if (double.tryParse(volumeTextField.text) != null && (double.tryParse(volumeTextField.text) < 12.0 && double.tryParse(volumeTextField.text) > 0.5)){
          if (double.tryParse(mileageTextField.text) != null && (int.tryParse(mileageTextField.text) > 0 && int.tryParse(mileageTextField.text) < 3000000)){
            if (img_array.length > 1){
              _sendCarInfo(context);
            }
            else{
              final snackBar = SnackBar(content: Text('Добавьте фото автомобиля.'));
              globalKey.currentState.showSnackBar(snackBar);
            }
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

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(AppConstants.key);
  }

  Future<int> getUID() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(AppConstants.uid);
  }

  _sendCarInfo(context) async {
    var token = await getToken();
    var array = img_array;
    array.removeLast();
    var formData = FormData.fromMap({
      'name' : brandTextField.text,
      'year' : int.parse(yearTextField.text),
      'size' : double.parse(volumeTextField.text),
      'milage' : double.parse(mileageTextField.text),
    });

    for (File item in array)
      formData.files.addAll([
        MapEntry("images", await MultipartFile.fromFile(item.path, filename: basename(item.path))),
      ]);

    globalKey.currentState.showSnackBar(
      SnackBar(duration: new Duration(seconds: 60), content:
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircularProgressIndicator(),
            ),
            Text("  Загрузка...  "),
          ],
        ),
      )
    );

    var response = await Dio().post(
      AppConstants.baseUrl + AppConstants.carsUrl, 
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
        }
      ),
      onSendProgress: (int sent, int total) {
        print("$sent / $total");
      },
    ).then((response) {
      print(response);
      globalKey.currentState.removeCurrentSnackBar();
    }).catchError((error) => print(error));

    // String jsonString = await addCar(uid, token, brandTextField.text, int.parse(yearTextField.text), double.parse(volumeTextField.text), double.parse(mileageTextField.text), img_array);
    // Map<String, dynamic> decodedJson = jsonDecode(jsonString);
    // if (decodedJson['status'] == 'ok'){
    //   Navigator.pop(context);
    // }
  }

}

Future<String> addCar(int userID, String token, String name, int year, double size, double milage, List<File> carImg) async {
  final response = await http.post(AppConstants.baseUrl + AppConstants.carsUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      },
      body: jsonEncode(<String, Object>{
        'name' : name,
        'year' : year,
        'size' : size,
        'milage' : milage,
        'images' : carImg
      }));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Falied to Change Profile Information.");
  }
}