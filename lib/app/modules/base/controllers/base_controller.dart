import 'package:get/get.dart';
import '../../../../utils/dummy_helper.dart';
import '../../favorites/controllers/favorites_controller.dart';

class BaseController extends GetxController {
  // Current screen index
  int currentIndex = 0;

  int get cartCount {
    try {
      return DummyHelper.products
          .where((p) => (p.quantity ?? 0) > 0)
          .fold<int>(0, (sum, item) => sum + (item.quantity ?? 0));
    } catch (_) {
      return 0;
    }
  }

  /// Change the selected screen index
  void changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  /// When the user presses the favorite button on any product
  void onFavoriteButtonPressed({required int productId}) {
    var product = DummyHelper.products.firstWhere(
      (product) => product.id == productId,
    );
    product.isFavorite = !(product.isFavorite ?? false);

    try {
      Get.find<FavoritesController>().getFavoriteProducts();
    } catch (_) {}

    update(['FavoriteButton']);
  }

  void refreshCartBadge() {
    update(['CartBadge']);
  }
}
