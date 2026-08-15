import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/components/custom_snackbar.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'config/theme/my_theme.dart';
import 'services/stripe_service.dart';

Future<void> main() async {
  // Follow codexahmar

  // Wait for flutter bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Info: .env file not found or empty: $e");
  }

  // Initialize Stripe SDK globally on app startup
  await StripeService.instance.initStripe();

  // Init shared preferences
  await MySharedPref.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        bool themeIsLight = MySharedPref.getThemeIsLight();
        return GetMaterialApp(
          scaffoldMessengerKey: CustomSnackBar.messengerKey,
          title: "StripeCart",
          debugShowCheckedModeBanner: false,
          theme: MyTheme.getThemeData(isLight: true),
          darkTheme: MyTheme.getThemeData(isLight: false),
          themeMode: themeIsLight ? ThemeMode.light : ThemeMode.dark,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
            );
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
