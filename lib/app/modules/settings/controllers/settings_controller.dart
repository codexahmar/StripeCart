import 'package:get/get.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  bool get isLightTheme => MySharedPref.getThemeIsLight();

  void changeTheme(bool isDark) {
    MyTheme.changeTheme();
    update(['Theme']);
  }
}
