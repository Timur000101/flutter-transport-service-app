import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/core/const.dart';
import 'package:sto_app/models/menu_item.dart';
import 'package:sto_app/models/user_detail.dart';
import 'package:sto_app/pages/auth/signIn_page.dart';
import 'package:sto_app/pages/order/order_history_item.dart';
import 'package:sto_app/pages/order/order_history_page.dart';
import 'package:sto_app/pages/order/order_page.dart';
import 'package:sto_app/pages/profile/support_page.dart';
import 'package:sto_app/pages/request/request_cto_page.dart';
import 'package:sto_app/pages/request/request_page.dart';
import 'package:sto_app/pages/request/about_auto_page.dart';
import 'package:sto_app/pages/start_up.dart';
import 'package:sto_app/utils/alert.dart';
import 'package:sto_app/widgets/app_widgets.dart';
import '../create_identifier_page.dart';
import 'about_app_page.dart';
import 'edit_profile.dart';
import 'message_item.dart';
import 'message_page.dart';
import 'my_cars_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sto_app/utils/internet_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  String avaURL =
      "https://www.sunsetlearning.com/wp-content/uploads/2019/09/User-Icon-Grey.png";
  String name = "Пользователь";
  String phone = "+7 (___) ___-__-__";
  String secondPhone = "";
  String thirdPhone = "";

  bool isReg = false;

  bool isSwitched = false;

  List<MenuItem> menu1 = [
    MenuItem(
      title: "Мои автомобили",
      icon: Stoappicons.car_1,
    ),
    MenuItem(title: "Заказы", icon: Icons.history),
    MenuItem(title: "Сообщения", icon: Stoappicons.conversation),
  ];
  List<MenuItem> menu2 = [
    MenuItem(title: "Служба поддержки", icon: Stoappicons.customer_service),
    MenuItem(title: "Оценить приложение", icon: Stoappicons.star),
    MenuItem(title: "О приложении", icon: Icons.warning_rounded)
  ];

  sendDeviceToken() async {
    // print(AppConstants.isreg);
    if (AppConstants.isreg) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var isSended =
          sharedPreferences.getBool(AppConstants.isSendedDeviceToken);
      // print(isSended);
      if (isSended == null || isSended == false) {
        var token = sharedPreferences.getString(AppConstants.key);
        var deviceToken = sharedPreferences.getString(AppConstants.deviceToken);
        // print(deviceToken);
        var url = "${AppConstants.baseUrl}users/push/register/";
        var headers = {
          "Accept": "application/json",
          "Authorization": "Token $token"
        };
        final response = await http.post(url, headers: headers, body: {
          "reg_id": deviceToken,
          "cmt": Platform.isAndroid ? "fcm" : "apn"
        });

        if (response.statusCode == 200) {
          Map<String, dynamic> status = jsonDecode(response.body);
          if (status['status'] == "ok") {
            sharedPreferences.setBool(AppConstants.isSendedDeviceToken, true);
            print("sended device token");
          }
        }
      }
    }
  }

  Future<UserDetail> getUserDetail(int userId, String token) async {
    var url = "${AppConstants.baseUrl}${AppConstants.getUserDetail}$userId";
    final response = await http.get(url, headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Token $token"
    });

    if (response.statusCode == 200) {
      return UserDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falied to getUserDetail");
    }
  }

  void getuserdetail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isReg = sharedPreferences.getBool(AppConstants.isReg);
    if (isReg == true) {
      var userId = sharedPreferences.getInt(AppConstants.uid);
      var token = sharedPreferences.getString(AppConstants.key);
      UserDetail userDetail = await getUserDetail(userId, token);

      setState(() {
        String number = userDetail.phone.substring(1, userDetail.phone.length);
        phone =
            "+7 (${number.substring(1, 4)}) ${number.substring(4, 7)}-${number.substring(7, 9)}-${number.substring(9, 11)}";
        if (AppConstants.role) {
          // if (userDetail.ctoName != null) {
          name = userDetail.ctoName;
          // if (userDetail.avatar !=
          //     "${AppConstants.baseUrl}media/default/default.png")
          avaURL = userDetail.avatar;
          // }
          // if (userDetail.ctoLogo != null) {
          //   if (userDetail.ctoLogo !=
          //       "${AppConstants.baseUrl}media/default/default.png")
          //     avaURL = userDetail.ctoLogo;
          // }

        } else {
          name = userDetail.nickname;
          // if (userDetail.avatar !=
          //     "${AppConstants.baseUrl}media/default/default.png")
          avaURL = userDetail.avatar;
        }
      });

      secondPhone = userDetail.secondPhone;
      thirdPhone = userDetail.thirdPhone;

      if (secondPhone != null) {
        secondPhone = "+${secondPhone}";
      }
      if (thirdPhone != null) {
        thirdPhone = "+${thirdPhone}";
      }

      // if (userDetail.secondPhone.isNotEmpty) {
      //   String number = userDetail.secondPhone
      //       .toString()
      //       .substring(1, userDetail.secondPhone.toString().length);
      //   secondPhone =
      //       "+7 (${number.substring(1, 4)}) ${number.substring(4, 7)}-${number.substring(7, 9)}-${number.substring(9, 11)}";
      // }
      //
      // if (userDetail.thirdPhone != null) {
      //   String number = userDetail.thirdPhone
      //       .toString()
      //       .substring(1, userDetail.thirdPhone.toString().length);
      //   thirdPhone =
      //       "+7 (${number.substring(1, 4)}) ${number.substring(4, 7)}-${number.substring(7, 9)}-${number.substring(9, 11)}";
      // }
      // if (userDetail.ctoName != "") {
      //   AppConstants.isRegAsSTO = true;
      // }
      // setState(() {
      //   name = userDetail.ctoName;
      // });

      // print("${userDetail.ctoName} 123456789");
      // print("hello");

      sharedPreferences.setString(AppConstants.email, userDetail.email);
      sharedPreferences.setString(AppConstants.name, userDetail.nickname);
      sharedPreferences.setString(AppConstants.avatar, userDetail.avatar);
      sharedPreferences.setString(AppConstants.phone,
          userDetail.phone.substring(1, userDetail.phone.length));
      sharedPreferences.setString(AppConstants.ctoName, userDetail.ctoName);
      sharedPreferences.setString(AppConstants.ctoLogo, userDetail.ctoLogo);
      sharedPreferences.setString(
          AppConstants.ctoAddress, userDetail.ctoAddress);
      sharedPreferences.setString(
          AppConstants.secondPhone, userDetail.secondPhone);
      sharedPreferences.setString(
          AppConstants.thirdPhone, userDetail.thirdPhone);
    }
  }

  @override
  void initState() {
    super.initState();
    getRole();
    checkInternetConnection().then((value) => {
          if (value)

            {getuserdetail()}
          else
            {
              showAlert(
                  "Внимание", "У вас нет соединения с интернетом!", context)
            }
        });
    sendDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar("Профиль"),
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildProfileHeader(context),
          SizedBox(
            height: 15,
          ),
          Container(
              margin: EdgeInsets.only(bottom: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Основные",
                style: TextStyle(color: AppColors.primaryTextColor),
              )),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: menu1.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 2.5),
                  child: ListTile(
                    title: Text(menu1[index].title,
                        style: TextStyle(fontSize: 18)),
                    leading: Icon(
                      menu1[index].icon,
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    tileColor: Colors.white,
                    onTap: () {
                      if (isReg == true) {
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCarsPage()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderPage()));
                        } else if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MessagePage()));
                        }
                      } else {
                        showCustomAlert();
                      }
                    },
                  ),
                );
              }),
          Container(
              margin: EdgeInsets.only(bottom: 5.0, top: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Дополнительно",
                style: TextStyle(color: AppColors.primaryTextColor),
              )),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: menu2.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 2.5),
                  child: ListTile(
                      title: Text(menu2[index].title,
                          style: TextStyle(fontSize: 18)),
                      leading: Icon(
                        menu2[index].icon,
                        color: AppColors.mainColor,
                        size: 30,
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_outlined),
                      tileColor: Colors.white,
                      onTap: () {
                        if (isReg == true) {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SupportPage()),
                            );
                          } else if (index == 1) {
                            _launchURL();
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutAppPage()));
                          }
                        } else {
                          showCustomAlert();
                        }
                      }),
                );
              }),
          SizedBox(
            height: 30.0,
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 20.0),
          //   child: RaisedButton(
          //     onPressed: () {
          //      showLogOutAlert();
          //     },
          //     padding: const EdgeInsets.symmetric(vertical: 20.0),
          //     textColor: Colors.white,
          //     color: AppColors.mainColor,
          //     elevation: 3.0,
          //     child: Text("Выйти из аккаунта"),
          //   ),
          // ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 240,
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(avaURL),
                          radius: 50,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          phone,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.primaryTextColor),
                        ),
                        FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            onPressed: () {
                              if (isReg == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                            imageurl: avaURL,
                                            name: name,
                                            phone: phone,
                                            secondPhone: secondPhone,
                                            thirdPhone: thirdPhone,
                                          )),
                                ).whenComplete(() => {getuserdetail()});
                              } else {
                                showCustomAlert();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Редактировать",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.2,
                      child: SizedBox(
                        child: Switch(
                          value: AppConstants.role,
                          onChanged: (value) {
                            if (isReg == true) {
                              if (AppConstants.isRegAsSTO == true) {
                                setState(() {
                                  AppConstants.role = value;
                                  changeRole();
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateIdentifierPage()),
                                );
                              }
                            } else {
                              showCustomAlert();
                            }
                          },
                          activeTrackColor: AppColors.mainColor,
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                    userRoleText(),
                    SizedBox(
                      height: 5.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: userRoleDescriptionText(),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }

  getRole() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var isReg = sharedPreferences.getBool(AppConstants.isReg);
    // if (isReg) {
    //   var role = sharedPreferences.getBool(AppConstants.isClient);
    setState(() {
      isSwitched = AppConstants.role;
    });
    // }
  }

  userRoleText() {
    return !isSwitched
        ? Text(
            "Заказчик",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        : Text(
            "Исполнитель",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
  }

  changeRole() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!AppConstants.role) {
      sharedPreferences.setBool(AppConstants.isClient, false);
      avaURL = sharedPreferences.getString(AppConstants.avatar);
      name = sharedPreferences.getString(AppConstants.name);
    } else {
      sharedPreferences.setBool(AppConstants.isClient, true);
      avaURL = sharedPreferences.getString(AppConstants.ctoLogo);
      name = sharedPreferences.getString(AppConstants.ctoName);
    }
  }

  userRoleDescriptionText() {
    return !isSwitched
        ? Text(
            "Принимайте заказы в режиме исполнителей!",
            style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),
            textAlign: TextAlign.center,
          )
        : Text(
            "Выбирайте заказы на свое усмотрение!",
            style: TextStyle(fontSize: 16, color: AppColors.primaryTextColor),
            textAlign: TextAlign.center,
          );
  }

  showLogOutAlert() {
    var dialog = CustomAlertDialog(
        title: "Внимание",
        message: "Вы действительно хотите выйти из аккаунта?",
        onPostivePressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.clear();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        },
        positiveBtnText: 'Да',
        negativeBtnText: 'Нет');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  showCustomAlert() {
    var dialog = CustomAlertDialog(
        title: "Внимание",
        message: "Вы не зарегистрированы, зарегистрироваться?",
        onPostivePressed: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SignIn(),
            ),
            (route) => false,
          );
        },
        positiveBtnText: 'Да',
        negativeBtnText: 'Нет');
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }

  // https://play.google.com/store/apps/details?id=package_name
  _launchURL() async {
    var url = "";
    if (Platform.isAndroid) {
      url = "https://play.google.com/store/apps/";
    }
    if (Platform.isIOS) {
      url = 'https://apple.com';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
