import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/utils/internet_manager.dart';
import 'package:sto_app/utils/utils.dart';
import 'dart:io';
import 'package:sto_app/widgets/app_widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final String imageurl;
  final String name;
  final String phone;
  final String secondPhone;
  final String thirdPhone;

  const EditProfile({Key key, this.imageurl, this.name, this.phone, this.secondPhone, this.thirdPhone})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var nameTextField = TextEditingController();
  var additionalPhone1TextField = TextEditingController();
  var additionalPhone2TextField = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _mobileFormatter = NumberTextInputFormatter();

  @override
  void initState() {
    getAvatar(widget.imageurl);
    nameTextField.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: buildAppBar("Редактирование"),
          body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Stack(children: <Widget>[
                Container(
                    color: AppColors.backgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _imgFromGallery();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: avatarImage)),
                          ),
                        ),
                        Text('Сменить фото',
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: TextFormField(
                            controller: nameTextField,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.primaryTextColor,
                                fontWeight: FontWeight.bold),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'ФИО',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Введите ФИО';
                              } else if (value.length < 2) {
                                return 'Введите корректное ФИО';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 5, left: 30, right: 30),
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(children: [
                                          Text('Город',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          Spacer(),
                                          Text('Алматы',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors
                                                      .primaryTextColor)),
                                          // Icon(Icons.keyboard_arrow_right_outlined, size: 30),
                                        ]),
                                      ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  child: GestureDetector(
                                      onTap: () {
                                        // print('Change number');
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(children: [
                                          Text('Номер телефона',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          Spacer(),
                                          Text(widget.phone,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors
                                                      .primaryTextColor)),
                                          // Icon(
                                          //     Icons
                                          //         .keyboard_arrow_right_outlined,
                                          //     size: 30),
                                        ]),
                                      ))),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: TextFormField(
                            maxLength: 13,
                            keyboardType: TextInputType.phone,
                            controller: additionalPhone1TextField,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              _mobileFormatter,
                            ],
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.primaryTextColor,
                                fontWeight: FontWeight.bold),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Дополнительный телефон 1',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                              if (value.length < 13 && value.length > 1) {
                                return 'Введите корректный номер телефона';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: TextFormField(
                            maxLength: 13,
                            keyboardType: TextInputType.phone,
                            controller: additionalPhone2TextField,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              _mobileFormatter,
                            ],
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.primaryTextColor,
                                fontWeight: FontWeight.bold),
                            decoration: new InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Дополнительный телефон 2',
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            validator: (value) {
                              if (value.length < 13 && value.length > 1) {
                                return 'Введите корректный номер телефона';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                saveButtonPressed(context);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.red)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              textColor: Colors.white,
                              color: AppColors.mainColor,
                              elevation: 3.0,
                              child: Text(
                                "Сохранить",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ])))),
    ));
  }

  saveButtonPressed(context) {
    if (_formKey.currentState.validate()) {
      var isConnected = checkInternetConnection();
      isConnected.then((value) => {
        if (value){
          sendInfo(context)
        }
        else{
          showAlert(
              "Внимание", "У вас нет соединения с интернетом!", context)
        }
      });

      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  void getAvatar(String url) {
    if (url != null) {
      avatarImage = DecorationImage(fit: BoxFit.fill, image: NetworkImage(url));
    }
  }

  var avatarImage = DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage("assets/images/Add_ava_placeholder.png"));

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (image != null) {
        upload(image);
      }
    });
  }

  upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(AppConstants.baseUrl + AppConstants.changeAvatar);

    var request = new http.MultipartRequest("POST", uri);
    var token = await getToken();
    request.headers['authorization'] = "Token $token";
    var multipartFile = new http.MultipartFile('avatar', stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        avatarImage =
            DecorationImage(fit: BoxFit.fill, image: FileImage(imageFile));
      });
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

  sendInfo(context) async {
    var token = await getToken();
    var uid = await getUID();
    String jsonString = await changeProfile(uid, token, nameTextField.text, additionalPhone1TextField.text, additionalPhone2TextField.text);
    Map<String, dynamic> decodedJson = jsonDecode(jsonString);
    print(decodedJson);
    if (decodedJson['status'] == 'ok'){
      Navigator.pop(context);
    }
  }
}

Future<String> changeProfile(int userID, String token, String name, String addPhone1, String addPhone2) async {
  String secondP = "";
  String thirdP = "";
  if (addPhone1 != null){
    secondP = addPhone1;
  }
  if (addPhone2 != null){
    thirdP = addPhone2;
  }
  final response = await http.post(AppConstants.baseUrl + "users/detail/$userID",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      },
      body: jsonEncode(<String, String>{
        'nickname': name,
      }));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Falied to Change Profile Information.");
  }
}