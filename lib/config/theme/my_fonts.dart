import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFonts {
  static const String fontFamily = 'Poppins';

  // Base font style
  static TextStyle get getAppFontType => const TextStyle(
        fontFamily: fontFamily,
        letterSpacing: -0.2,
      );

  // Headlines & display fonts
  static TextStyle get displayTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      );

  static TextStyle get headlineTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      );

  // Body text font
  static TextStyle get bodyTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w400,
        letterSpacing: -0.1,
      );

  // Button text font
  static TextStyle get buttonTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  // App bar text font
  static TextStyle get appBarTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      );

  // Chips text font
  static TextStyle get chipTextStyle => getAppFontType.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      );

  // Font sizes
  static double get appBarTittleSize => 18.sp;

  static double get displayLargeSize => 28.sp;
  static double get displayMediumSize => 22.sp;
  static double get displaySmallSize => 16.sp;

  static double get bodyLargeSize => 18.sp;
  static double get bodyMediumSize => 14.sp;
  static double get bodySmallTextSize => 12.sp;

  static double get body1TextSize => 18.sp;
  static double get body2TextSize => 14.sp;

  static double get buttonTextSize => 15.sp;
  static double get captionTextSize => 12.sp;
  static double get chipTextSize => 11.sp;
}
