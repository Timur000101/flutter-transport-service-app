import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/utils/utils.dart';
import 'package:sto_app/widgets/app_widgets.dart';

class AddCarPage extends StatefulWidget {

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _mobileFormatter = NumberTextInputFormatter();
  
  TextEditingController phoneController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: buildAppBar("Добавить машину"),
         body:  Container(
              color: AppColors.backgroundColor,
              child: Column(
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
                    padding: const EdgeInsets.fromLTRB(15,5,15,5),
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
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0,10,15,20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            createAlertDialog(context);
                            setState(() {
                              isLoading = true;
                            });
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
            // /         padding: EdgeInsets.all(20.0),
            //         child: Column(
            //           children: <Widget>[
            //             SizedBox(
            //               height: 30.0,
            //             ),
            //             Container(
            //               child: TextFormField(
            //                 keyboardType: TextInputType.text,
            //                 controller: nickNameController,
            //                 decoration: InputDecoration(
            //                   labelText: "Выберите марку машины",
            //                   enabledBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(10.0),
            //                   ),
            //                 ),
            //                 validator: (value) {
            //                   if (value.isEmpty) {
            //                     return 'Выберите марку';
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10.0,
            //             ),
            //             Container(
            //               child: TextFormField(
            //                 keyboardType: TextInputType.phone,
            //                 controller: phoneController,
            //                 inputFormatters: <TextInputFormatter>[
            //                   _mobileFormatter,
            //                 ],
            //                 decoration: InputDecoration(
            //                   labelText: "Год машины",
            //                   enabledBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(10.0),
            //                   ),
            //                 ),
            //                 validator: (value) {
            //                   if (value.isEmpty) {
            //                     return 'Введите номер телефона';
            //                   } else if (!value.contains('+')) {
            //                     return 'Введите корректный номер телефона';
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10.0,
            //             ),
            //             Container(
            //               width: MediaQuery.of(context).size.width,
            //               child: RaisedButton(
            //                 onPressed: () {
            //                   if (_formKey.currentState.validate()) {
            //                     createAlertDialog(context);
            //                     setState(() {
            //                       isLoading = true;
            //                     });
            //                     FocusScopeNode currentFocus =
            //                         FocusScope.of(context);
            //                     if (!currentFocus.hasPrimaryFocus) {
            //                       currentFocus.unfocus();
            //                     }
            //                   }
            //                 },
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10.0),
            //                     side: BorderSide(color: Colors.red)),
            //                 padding: const EdgeInsets.symmetric(vertical: 20.0),
            //                 textColor: Colors.white,
            //                 color: AppColors.mainColor,
            //                 elevation: 3.0,
            //                 child: Text(
            //                   "Продолжить",
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )),
          ),
       );
  }
}