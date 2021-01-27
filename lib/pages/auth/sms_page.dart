import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/pages/home_page.dart';
import 'package:sto_app/utils/utils.dart';

class EnterSMS extends StatefulWidget {
  EnterSMS(this.vId, this.tkn, this.phoneN);
  final String vId;
  final int tkn;
  final String phoneN;

  @override
  _EnterSMSState createState() => _EnterSMSState();
}

class _EnterSMSState extends State<EnterSMS> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController smsController = TextEditingController();

  var isLoading = false;
  var repeatSend = false;
  int _start = 30;
  // Timer _timer;

  @override
  void initState() {
    super.initState();
    // repeatCodeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "Код подтверждения отправлен на номер ${widget.phoneN}",
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
                        decoration: InputDecoration(
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
                              createAlertDialog(context);
                              setState(() {
                                isLoading = true;
                              });
                              verifySMS(widget.vId, smsController.text.trim());
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
                            print("Nothing to do");
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

  // void repeatCodeTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = new Timer.periodic(
  //       oneSec,
  //       (Timer timer) => setState(() {
  //             if (_start == 0) {
  //               _start = 30;
  //             } else {
  //               setState(() {
  //                 _start--;
  //               });
  //               print(_start);
  //             }
  //           }));
  // }

  void verifySMS(String vID, String msg) async {
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
  }
}
