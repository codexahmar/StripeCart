import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/data/local/my_shared_pref.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static ThemeData getThemeData({required bool isLight}) {
    final primary = isLight
        ? LightThemeColors.primaryColor
        : DarkThemeColors.primaryColor;
    final secondary = isLight
        ? LightThemeColors.secondaryColor
        : DarkThemeColors.secondaryColor;
    final surface = isLight
        ? LightThemeColors.surfaceColor
        : DarkThemeColors.surfaceColor;
    final scaffoldBg = isLight
        ? LightThemeColors.scaffoldBackgroundColor
        : DarkThemeColors.scaffoldBackgroundColor;
    final cardBg = isLight
        ? LightThemeColors.cardColor
        : DarkThemeColors.cardColor;

    return ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: scaffoldBg,
      cardColor: cardBg,
      hintColor: isLight
          ? LightThemeColors.hintTextColor
          : DarkThemeColors.hintTextColor,

      colorScheme: ColorScheme(
        brightness: isLight ? Brightness.light : Brightness.dark,
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        error: const Color(0xFFEF4444),
        onError: Colors.white,
        surface: surface,
        onSurface: isLight
            ? LightThemeColors.displayTextColor
            : DarkThemeColors.displayTextColor,
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: isLight
            ? LightThemeColors.dividerColor
            : DarkThemeColors.dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
      ),

      // AppBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),

      // ElevatedButton theme
      elevatedButtonTheme: MyStyles.getElevatedButtonTheme(
        isLightTheme: isLight,
      ),

      // Text theme
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),

      // Chip theme
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),

      // Icon theme
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
    );
  }

  /// Update app theme and save theme type to shared pref
  static void changeTheme() {
    bool isLightTheme = MySharedPref.getThemeIsLight();
    MySharedPref.setThemeIsLight(!isLightTheme);
    Get.changeTheme(getThemeData(isLight: !isLightTheme));
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  /// Check if the theme is light or dark
  static bool get isThemeLight => MySharedPref.getThemeIsLight();
}
