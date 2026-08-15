import 'package:get/get.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class FavoritesController extends GetxController {
  List<ProductModel> products = [];

  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }

  void getFavoriteProducts() {
    products =
        DummyHelper.products.where((p) => p.isFavorite == true).toList();
    update();
  }

  void addAllToCart() {
    if (products.isEmpty) return;

    for (var product in products) {
      product.quantity = (product.quantity ?? 0) + 1;
      product.size ??= 'M';
    }

    try {
      Get.find<CartController>().getCartProducts();
      Get.find<BaseController>().refreshCartBadge();
    } catch (_) {}

    CustomSnackBar.showCustomSnackBar(
      title: 'Added All to Bag 🎉',
      message: '${products.length} wishlist items moved to your shopping bag.',
    );
  }
}
