import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kThemeModeKey = '__theme_mode__';

abstract class FlutterFlowTheme {

  static FlutterFlowTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  Color? primaryColor;
  Color? secondaryColor;
  Color? tertiaryColor;
  Color? alternate;
  Color? primaryBackground;
  Color? secondaryBackground;
  Color? primaryText;
  Color? secondaryText;

  Color? sanctumColor;
  Color? textBoxBg2;
  Color? whiteBlack;
  Color? greyScale;
  Color? primatyTextboxBg;
  Color? primarySanctumTextBg;

  TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );

  TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF757575),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF616161),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );

  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );

  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF424242),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  Color? primaryColor = const Color(0xFFFF7701);
  Color? secondaryColor = const Color(0xFF0E0E0E);
  Color? tertiaryColor = const Color(0xFFECECEC);
  Color? alternate = const Color(0x00000000);
  Color? primaryBackground = const Color(0xFFECECEC);
  Color? secondaryBackground = const Color(0xFF0E0E0E);
  Color? primaryText = const Color(0xFF0E0E0E);
  Color? secondaryText = const Color(0x00000000);

  Color? sanctumColor = Color(0xFFFF7701);
  Color? textBoxBg2 = Color(0xFFDEDEDE);
  Color? whiteBlack = Color(0xFFE6E6E6);
  Color? greyScale = Color(0x58000000);
  Color? primatyTextboxBg = Color(0xFFE0E0E0);
  Color? primarySanctumTextBg = Color(0xFFDA6500);
}

class DarkModeTheme extends FlutterFlowTheme {
  Color? primaryColor = const Color(0xFF0E0E0E);
  Color? secondaryColor = const Color(0xFFECECEC);
  Color? tertiaryColor = const Color(0xFF0E0E0E);
  Color? alternate = const Color(0xFFD2D2D2);
  Color? primaryBackground = const Color(0xFF111111);
  Color? secondaryBackground = const Color(0xFF605F5F);
  Color? primaryText = const Color(0xFFECECEC);
  Color? secondaryText = const Color(0xFFE5E5E5);

  Color? sanctumColor = Color(0xFFFF7911);
  Color? textBoxBg2 = Color(0xFFDEDEDE);
  Color? whiteBlack = Color(0xFF0E0E0E);
  Color? greyScale = Color(0x00000000);
  Color? primatyTextboxBg = Color(0xFF444444);
  Color? primarySanctumTextBg = Color(0xFF444444);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    required String fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              height: lineHeight,
            );
}
