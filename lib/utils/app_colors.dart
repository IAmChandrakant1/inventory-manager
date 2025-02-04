import 'package:flutter/material.dart';

var grayColor = const Color(0xffd0d0da);
Color kBlack = Colors.black;
Color kWhite = Colors.white;
Color kDark = const Color(0xFFF1C1C1E);



Color greyScale = const Color(0x58000000);
Color primarySanctumTextBg = const Color(0xFFDA6500);
Color whiteBlack = const Color(0xFFE6E6E6);
Color textHintColor = const Color(0xFF303030);
Color btnBgColor = const Color(0xFF1D1D1D);
Color textColor = const Color(0xFF1D1D1D);
Color bottomNavBarColor = const Color(0xFFFAFAFA);
Color screenBgColor = const Color(0xFFECECEC);
Color profileCameraBgColor = const Color(0xFF818181);


Color kTrans = const Color(0x0);
Color kBlue = const Color(0xFF223455);
Color backgroundColor = const Color.fromARGB(255, 255, 119, 0);

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
