// import 'package:flutter_screenutil/flutter_screenutil.dart';

const appName = "Warker Apps";
const paddingAll = 16;
const String newsKey = "3fe817e193a64ce1b08bea4d03f80077";

//api Path
class ApiConfig {
  final String post = "posts";
}

String capitalizeFirstWord(String s) {
  if (s.isEmpty) {
    return s;
  }
  return s[0].toUpperCase() + s.substring(1);
}
