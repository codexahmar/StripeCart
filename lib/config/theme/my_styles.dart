import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dark_theme_colors.dart';
import 'my_fonts.dart';
import 'light_theme_colors.dart';

class MyStyles {
  /// Icons theme
  static IconThemeData getIconTheme({required bool isLightTheme}) =>
      IconThemeData(
        color: isLightTheme
            ? LightThemeColors.iconColor
            : DarkThemeColors.iconColor,
        size: 22.r,
      );

  /// App bar theme
  static AppBarTheme getAppBarTheme({required bool isLightTheme}) =>
      AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: MyFonts.appBarTextStyle.copyWith(
          color: isLightTheme
              ? LightThemeColors.displayTextColor
              : DarkThemeColors.displayTextColor,
          fontSize: MyFonts.appBarTittleSize,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(
          color: isLightTheme
              ? LightThemeColors.appBarIconsColor
              : DarkThemeColors.appBarIconsColor,
        ),
        backgroundColor: isLightTheme
            ? LightThemeColors.appBarColor
            : DarkThemeColors.appbarColor,
      );

  /// Text theme
  static TextTheme getTextTheme({required bool isLightTheme}) {
    final displayColor = isLightTheme
        ? LightThemeColors.displayTextColor
        : DarkThemeColors.displayTextColor;
    final bodyColor = isLightTheme
        ? LightThemeColors.bodyTextColor
        : DarkThemeColors.bodyTextColor;
    final bodySmallColor = isLightTheme
        ? LightThemeColors.bodySmallTextColor
        : DarkThemeColors.bodySmallTextColor;

    return TextTheme(
      displayLarge: MyFonts.displayTextStyle.copyWith(
        fontSize: MyFonts.displayLargeSize,
        fontWeight: FontWeight.w800,
        color: displayColor,
        letterSpacing: -0.8,
      ),
      displayMedium: MyFonts.displayTextStyle.copyWith(
        fontSize: MyFonts.displayMediumSize,
        fontWeight: FontWeight.w700,
        color: displayColor,
        letterSpacing: -0.5,
      ),
      displaySmall: MyFonts.displayTextStyle.copyWith(
        fontSize: MyFonts.displaySmallSize,
        fontWeight: FontWeight.w600,
        color: displayColor,
        letterSpacing: -0.2,
      ),
      headlineMedium: MyFonts.headlineTextStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: displayColor,
      ),
      titleLarge: MyFonts.headlineTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: displayColor,
      ),
      titleMedium: MyFonts.bodyTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: displayColor,
      ),
      bodyLarge: MyFonts.bodyTextStyle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: MyFonts.bodyLargeSize,
        color: bodyColor,
      ),
      bodyMedium: MyFonts.bodyTextStyle.copyWith(
        fontSize: MyFonts.bodyMediumSize,
        fontWeight: FontWeight.w400,
        color: bodyColor,
        height: 1.4,
      ),
      bodySmall: MyFonts.bodyTextStyle.copyWith(
        fontSize: MyFonts.bodySmallTextSize,
        fontWeight: FontWeight.w400,
        color: bodySmallColor,
      ),
      labelLarge: MyFonts.buttonTextStyle.copyWith(
        fontSize: MyFonts.buttonTextSize,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: MyFonts.chipTextStyle.copyWith(
        fontSize: MyFonts.chipTextSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Chip theme
  static ChipThemeData getChipTheme({required bool isLightTheme}) {
    return ChipThemeData(
      backgroundColor: isLightTheme
          ? LightThemeColors.chipBackground
          : DarkThemeColors.chipBackground,
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      labelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      secondaryLabelStyle: getChipTextStyle(isLightTheme: isLightTheme),
      selectedColor: isLightTheme
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,
      disabledColor: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: isLightTheme
              ? LightThemeColors.primaryColor.withValues(alpha: 0.15)
              : DarkThemeColors.primaryColor.withValues(alpha: 0.25),
        ),
      ),
    );
  }

  /// Chips text style
  static TextStyle getChipTextStyle({required bool isLightTheme}) {
    return MyFonts.chipTextStyle.copyWith(
      fontSize: MyFonts.chipTextSize,
      fontWeight: FontWeight.w600,
      color: isLightTheme
          ? LightThemeColors.chipTextColor
          : DarkThemeColors.chipTextColor,
    );
  }

  /// Elevated button text style
  static WidgetStateProperty<TextStyle?>? getElevatedButtonTextStyle(
    bool isLightTheme, {
    bool isBold = true,
    double? fontSize,
  }) {
    return WidgetStateProperty.resolveWith<TextStyle>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return MyFonts.buttonTextStyle.copyWith(
            fontSize: fontSize ?? MyFonts.buttonTextSize,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            color: isLightTheme
                ? LightThemeColors.buttonDisabledTextColor
                : DarkThemeColors.buttonDisabledTextColor,
          );
        }
        return MyFonts.buttonTextStyle.copyWith(
          fontSize: fontSize ?? MyFonts.buttonTextSize,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          color: isLightTheme
              ? LightThemeColors.buttonTextColor
              : DarkThemeColors.buttonTextColor,
        );
      },
    );
  }

  /// Elevated button theme data
  static ElevatedButtonThemeData getElevatedButtonTheme({
    required bool isLightTheme,
  }) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
          ),
          textStyle: getElevatedButtonTextStyle(isLightTheme),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return isLightTheme
                    ? LightThemeColors.primaryDark
                    : DarkThemeColors.primaryLight;
              } else if (states.contains(WidgetState.disabled)) {
                return isLightTheme
                    ? LightThemeColors.buttonDisabledColor
                    : DarkThemeColors.buttonDisabledColor;
              }
              return isLightTheme
                  ? LightThemeColors.buttonColor
                  : DarkThemeColors.buttonColor;
            },
          ),
        ),
      );
}
