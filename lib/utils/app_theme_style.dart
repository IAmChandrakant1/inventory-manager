import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

const String poppinsRegular = 'PoppinsRegular';
const String poppinsMedium = 'PoppinsMedium';
const String poppinsBold = 'PoppinsBold';
const String poppinsSemiBold = 'PoppinsSemiBold';
const String poppinsLight = 'PoppinsLight';
const String meriendaOneRegular = 'MeriendaOneRegular';
const String samanRegular = 'SamanRegular';

TextStyle smallTextStyle({
  size,
  color,
  family,
  letterSpacing,
  fontWeight,
}) {
  return TextStyle(
    fontSize: size ?? 12.sp,
    color: color ?? kBlack,
    fontFamily: family ?? poppinsRegular,
    letterSpacing: letterSpacing ?? 0.0,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}

TextStyle mediumTextStyle({
  size,
  color,
  family,
  fontWeight,
  letterSpacing,
}) {
  return TextStyle(
    fontSize: size ?? 14.sp,
    color: color ?? kBlack,
    fontFamily: family ?? poppinsMedium,
    letterSpacing: letterSpacing ?? 0.0,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}

TextStyle largeTextStyle({
  size,
  color,
  family,
  fontWeight,
}) {
  return TextStyle(
    fontSize: size ?? 16.sp,
    color: color ?? kBlack,
    fontFamily: family ?? poppinsBold,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
}

TextStyle appTextStyle({
  size,
  color,
  family,
  fontWeight,
}) {
  return TextStyle(
    shadows: [
      Shadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 2)
    ],
    fontSize: size ?? 12.sp,
    color: color ?? kBlack,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    fontFamily: family ?? samanRegular,
  );
}
