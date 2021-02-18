import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/car.dart';
import 'package:sto_app/pages/profile/my_cars_page.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:http/http.dart' as http;

class ServiceFinish extends StatefulWidget {
  final int servicePK;
  ServiceFinish({this.servicePK});

  @override
  _ServiceFinishState createState() => _ServiceFinishState();
}

class _ServiceFinishState extends State<ServiceFinish> {
  List<File> img_array = [File('assets/images/Add_photo_placeholder.png')];
  final globalKey = GlobalKey<ScaffoldState>();
  List<Car> carList = new List<Car>();
  List<DropdownMenuItem> itemList = List<DropdownMenuItem>();
  Object _value;
  var carId = -1;
  var problemTextField = TextEditingController();

  void initState() {
    super.initState();
    getCars();
    print(widget.servicePK);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Подробнее"),
      body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:SingleChildScrollView(
        reverse: true,
        child:Container(
        width: MediaQuery.of(context).size.width,
        height: 600,
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
                      hint: new Text("Выберите машину"),
                      value: _value,
                      items: itemList,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          carId = value;
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
                    controller: problemTextField,
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
      )
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


  _createOrder() async {
    if (carId != -1){
      if (problemTextField.text.length > 2){
        if (img_array.length > 1){
          var token = await getToken();
          var array = img_array;
          array.removeLast();
          var uri = Uri.parse(AppConstants.baseUrl + 'order/');
          var request = new http.MultipartRequest("POST", uri);
          request.headers['authorization'] = "Token $token";
          request.fields['car_id'] = carId.toString();
          request.fields['service_id'] = widget.servicePK.toString();
          request.fields['subservice_id'] = widget.servicePK.toString();
          request.fields['about'] = problemTextField.text;
          for (File item in array){
            var stream =
              new http.ByteStream(DelegatingStream.typed(item.openRead()));
            var length = await item.length();
            var multipartFile = new http.MultipartFile('images', stream, length,
                filename: basename(item.path));
            request.files.add(multipartFile);
          }

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

          var response = await request.send();
          print(response.statusCode);
          if (response.statusCode == 200){
            // Navigator.pop(context);
            print("Sucess");
          }
        }
        else{
          final snackBar = SnackBar(content: Text('Добавьте фото для подробности...'));
          globalKey.currentState.showSnackBar(snackBar);
        }
      }
      else{
        final snackBar = SnackBar(content: Text('Опишите проблему...'));
        globalKey.currentState.showSnackBar(snackBar);
      }
    }
    else{
      final snackBar = SnackBar(content: Text('Выберите машину или добавьте в профиле...'));
      globalKey.currentState.showSnackBar(snackBar);
    }

  }

  getCars() async {
    var token = await getToken();
    List<Car> list = await getMyCars(token);
    List<DropdownMenuItem> list1 = List<DropdownMenuItem>();
    int count = 0;
    for (var i in list){
      count+=1;
      list1.add(
        DropdownMenuItem(child: Text(i.name), value: i.id)
      );
    }
    setState(() {
      itemList = list1;
    });
  }
}
