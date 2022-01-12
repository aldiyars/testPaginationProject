import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Статичекий Tема, стили, цветы, размеры
class AppTheme {
  static var mainTS = GoogleFonts.rubik().copyWith(color: kDarkBlackColor, fontSize: appDefaultFontSize);

  static var mainTxtTheme = GoogleFonts.rubikTextTheme().copyWith(
    button: mainTS.copyWith(fontSize: 14.0.w, fontWeight: FontWeight.bold, color: kDarkBlackColor),
    overline: mainTS.copyWith(fontSize: 14.0.w),
    subtitle1: mainTS.copyWith(fontSize: appSubtitleFontSize, color: kDarkBlackColor),
    subtitle2: mainTS.copyWith(fontSize: appSubtitleFontSize2, color: kDarkBlackColor),
    headline5: mainTS.copyWith(fontSize: 24.0.w),
    headline6: mainTS.copyWith(fontSize: 14.0.w, fontWeight: FontWeight.bold),
  );

  static const Color kWhiteColor = Color(0xffffffff);
  static const Color kGreenColor = Colors.green;

  static const Color kRedColor = Colors.redAccent;
  static const Color kGrayColor = Colors.grey;
  static const Color kDarkGrayColor = Color(0xFF7B7B7B);
  static const kDarkBlackColor = Colors.black87;

  static double appDefaultFontSize = 14.0.w;
  static double appTitleFontSize = 16.0.w;
  static double appSubtitleFontSize = 13.0.w;
  static double appSubtitleFontSize2 = 11.0.w;
}
