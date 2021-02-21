import 'package:flutter/widgets.dart';

class AppColors {
  static final Color backgroundColor = Color(0XFFEDF2F4);
  static final Color mainColor = Color(0XFFEF233C);
  static final Color primaryColor = Color(0XFF35953E);
  static final Color mainTextColor = Color(0XFF000000);
  static final Color primaryTextColor = Color(0XFF717171);
  static final Color lightColor = Color(0XFFFFFFFF);
  static final Color redColor = Color(0XFFF55367);
  static final Color greenColor = Color(0XFF35953E);
}

class AppConstants {
  static final String baseUrl = "http://134.122.11.57/";
  static final String getUserDetail = "users/detail/";
  static final String changeAvatar = "users/change/avatar/";
  static final String carsUrl = "cars/";

  static final String phone = "phone";
  static final String uid = "uid";
  static final String name = "name";
  static final String key = "key";
  static final String isReg = "isReg";
  static final String email = "email";
  static final String avatar = "avatar";
  static final String isClient =  "role";
  static final String isRegAsCto = "isregascto";

  static final String ctoLogo = "ctoAvatar";
  static final String ctoName = "ctoName";
  static final String ctoAddress = "ctoAddress";

  /////////////////////////////////
  static bool isRegAsSTO =  false;
  static bool isreg = false;
  // if role == false User or role == true CTO
  static bool role = false;
}

class Stoappicons {
  Stoappicons._();

  static const _kFontFam = 'Stoappicons';
  static const String _kFontPkg = null;

  static const IconData profile_icon =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData conversation =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData car_1 =
      IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData customer_service =
      IconData(0xe803, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData edit_1 =
      IconData(0xe804, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData history_2 =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData star =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData vector =
      IconData(0xe807, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData car_model =
      IconData(0xe808, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData calendar =
      IconData(0xe809, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData engine_volume =
      IconData(0xe80a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData distance =
      IconData(0xe80b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData edit =
      IconData(0xe80c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData add_file =
      IconData(0xe80d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData raphael_roadmap =
      IconData(0xe80e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData trash_2 =
      IconData(0xe80f, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData vector_3 =
      IconData(0xe810, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData vector_1 =
      IconData(0xe811, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData vector_2 =
      IconData(0xe812, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData dashicons_arrow_left_alt2 =
      IconData(0xe813, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData services_icon =
      IconData(0xe814, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData request_icon =
      IconData(0xe815, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
