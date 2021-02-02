import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/models/sms_response.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:sto_app/utils/internet_manager.dart';

import 'package:http/http.dart' as http;

Future<SmsResponse> verification(String phone, String code) async {
  final response = await http.post(AppConstants.baseUrl + "users/code/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'phone': phone, 'code': code}));

  if (response.statusCode == 200) {
    return SmsResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Falied to registration");
  }
}

Future<String> registration(String phone, String name) async {
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

class EnterSMS extends StatefulWidget {
  EnterSMS(this.nickname, this.phone);
  final String nickname;
  // final int tkn;
  final String phone;

  @override
  _EnterSMSState createState() => _EnterSMSState();
}

class _EnterSMSState extends State<EnterSMS> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController smsController = TextEditingController();

  var isLoading = false;
  var repeatSend = false;
  int _start = 30;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    repeatCodeTimer();
  }

  @override
  void dispose() {
    _timer = null;
    _timer.cancel();
    super.dispose();
  }

  void ver(String phone, String code) async {
    SmsResponse smsResponse = await verification(phone, code);

    if (smsResponse.status == "ok") {
      saveToLocal(
          phone, smsResponse.key, smsResponse.nickname, smsResponse.uid);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.pop(context);
      showAlert("Внимание", "вы ввели неправильный код", context);
    }
  }

  void reg(String nickname, String phone) async {
    String jsonString = await registration(
      phone,
      nickname,
    );
    Map<String, dynamic> status = jsonDecode(jsonString);
    // print(status['status']);

    if (status['status'] == "ok") {
      _start = 30;
      Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("на ваш телефон отправлен смс")));
    } else {
      Navigator.pop(context);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
        'Проверьте соединения с интернетом или попробуйте позже!',
      )));

      // print("status no ok");
    }
  }

  void saveToLocal(String phone, String key, String name, int uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.key, key);
    prefs.setString(AppConstants.name, name);
    prefs.setInt(AppConstants.uid, uid);
    prefs.setString(AppConstants.phone, phone);
    prefs.setBool(AppConstants.isReg, true);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Введите код",
                          style: TextStyle(
                              color: AppColors.mainTextColor,
                              letterSpacing: 1.0,
                              fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Код подтверждения отправлен на номер ${widget.phone}",
                          style: TextStyle(
                              color: AppColors.mainTextColor, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Введите проверочный код:",
                          style: TextStyle(
                              color: AppColors.primaryTextColor, fontSize: 14),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: smsController,
                        maxLength: 4,
                        decoration: InputDecoration(
                          counterText: "",
                          labelText: "Код",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите код';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              checkInternetConnection().then((value) => {
                                    if (value)
                                      {
                                        createAlertDialog(context),
                                        setState(() {
                                          isLoading = true;
                                        }),
                                        ver(widget.phone,
                                            smsController.text.toString())
                                      }
                                    else
                                      {
                                        showAlert(
                                            "Внимание",
                                            "У вас нет соединения с интернетом!",
                                            context)
                                      }
                                  });

                              // verifySMS(widget.vId, smsController.text.trim());
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
                            "Отправить код",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.5),
                        height: 30,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          onPressed: () async {
                            if (_start == 0) {
                              checkInternetConnection().then((value) => {
                                    if (value)
                                      {
                                        reg(widget.nickname, widget.phone),
                                        createAlertDialog(context),
                                        setState(() {
                                          isLoading = true;
                                        }),
                                      }
                                    else
                                      {
                                        showAlert(
                                            "Внимание",
                                            "У вас нет соединения с интернетом!",
                                            context)
                                      }
                                  });
                            } else {}
                          },
                          textColor: Colors.blue,
                          splashColor: Colors.grey.withOpacity(0.5),
                          child:
                              Text("Повторно отправить код через ${_start} с."),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FlatButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          textColor: Colors.blue,
                          splashColor: Colors.grey.withOpacity(0.5),
                          child: Text("Ввести другой номер телефона"),
                        ),
                      ),
                    ])))));
  }

  void repeatCodeTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start == 0) {
                // _start = 30;
              } else {
                setState(() {
                  _start--;
                });
                // print(_start);
              }
            }));
  }

  // void verifySMS(String vID, String msg) async {
  // PhoneAuthCredential phoneAuthCredential =
  //     PhoneAuthProvider.credential(verificationId: vID, smsCode: msg);
  // try {
  //   await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
  //   setState(() {
  //     isLoading = false;
  //   });

  //   Navigator.of(context).popUntil((route) => route.isFirst);
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage()),
  //   );
  // } catch (err) {
  //   setState(() {
  //     isLoading = false;
  //   });
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Код не верный"),
  //           content: Text(err.message),
  //           actions: [
  //             FlatButton(
  //               child: Text("OK"),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
  // }
}
