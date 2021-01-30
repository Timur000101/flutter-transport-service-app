import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/auth/sms_page.dart';
// import 'package:sto_app/pages/home_page.dart';
// import 'package:sto_app/pages/sms_page.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:connectivity/connectivity.dart';

Future<String> registration(String name, String phone) async {
  final response = await http.post(AppConstants.baseUrl + "users/phone/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phone,
        'nickname': name,
      }));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception("Falied to registration");
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

TextEditingController nameController = TextEditingController();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _mobileFormatter = NumberTextInputFormatter();

  TextEditingController phoneController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = '';
  }

  String cleanPhone(String phone) {
    var ph = "";
    for (int i = 0; i < phone.length; i++) {
      if (isNumeric(phone[i])) {
        ph += phone[i];
      }
    }
    return ph.substring(1, ph.length);
  }

  void reg(String nickname, String phone) async {
    String jsonString = await registration(
      cleanPhone(phone),
      nickname,
    );
    Map<String, dynamic> status = jsonDecode(jsonString);
    // String status = jsonEncode(statusJson);
    print(status['status']);

    if (status['status'] == "ok") {
      print("status ok");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EnterSMS(nickname, phone)),
      );
    } else {
      print("status no ok");
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/logo_FS_color.jpg",
                            width: MediaQuery.of(context).size.width - 100,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Вход/Регистрация",
                            style: TextStyle(
                                color: AppColors.primaryTextColor,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nickNameController,
                            decoration: InputDecoration(
                              labelText: "Введите имя",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Введите имя';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly,
                              _mobileFormatter,
                            ],
                            decoration: InputDecoration(
                              labelText: "Введите номер",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Введите номер телефона';
                              } else if (!value.contains('+')) {
                                return 'Введите корректный номер телефона';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text:
                                    'Нажимая "Продолжить", вы соглашаетесь с ',
                              ),
                              TextSpan(
                                  text: "обработкой персональных данных ",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              TextSpan(
                                text: "и ",
                              ),
                              TextSpan(
                                  text: "правилами сервиса ",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                            ]))),
                        Divider(
                          color: Colors.grey.withOpacity(0.5),
                          height: 30,
                          thickness: 1.5,
                          indent: 50,
                          endIndent: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // createAlertDialog(context);
                                setState(() {
                                  isLoading = true;
                                });
                                var isConnected = checkInternetConnection();
                                isConnected.then((value) => {
                                      if (value)
                                        {
                                          reg(nickNameController.text,
                                              phoneController.text.trim())
                                        }
                                      else
                                        {
                                          _showDialog(
                                              "Внимание",
                                              "У вас нет соединения с интернетом!",
                                              context)
                                        }
                                    });

                                // registerToFb(phoneController.text.trim());
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.red)),
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            textColor: Colors.white,
                            color: AppColors.mainColor,
                            elevation: 3.0,
                            child: Text(
                              "Продолжить",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }

  void _showDialog(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]);
        });
  }
  // void registerToFb(String phoneNumber) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 60),
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);

  //       setState(() {
  //         isLoading = false;
  //       });

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (BuildContext context) => HomePage()),
  //       );
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       var msg;
  //       if (e.code == 'invalid-phone-number') {
  //         msg = 'Invalid number. Enter again.';
  //       } else {
  //         msg = e.message;
  //       }

  //       setState(() {
  //         isLoading = false;
  //       });

  //       showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: Text("Error"),
  //               content: Text(msg.toString()),
  //               actions: [
  //                 FlatButton(
  //                   child: Text("OK"),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 )
  //               ],
  //             );
  //           });
  //     },
  //     codeSent: (String verificationId, int resendToken) {
  //       setState(() {
  //         isLoading = false;
  //       });

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //                 EnterSMS(verificationId, resendToken, phoneNumber)),
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     },
  //   );
  // }

}
