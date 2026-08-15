import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  late ProductModel product;

  var selectedSize = 'M';
  Color? selectedColor;
  int quantity = 1;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
    selectedSize = product.size ?? 'M';
    if (product.availableColors != null && product.availableColors!.isNotEmpty) {
      selectedColor = product.selectedColor ?? product.availableColors!.first;
    }
  }

  void onFavoriteButtonPressed() {
    product.isFavorite = !(product.isFavorite ?? false);
    try {
      Get.find<BaseController>().onFavoriteButtonPressed(productId: product.id!);
    } catch (_) {}
    update(['FavoriteButton']);
  }

  void changeSelectedSize(String size) {
    if (size == selectedSize) return;
    selectedSize = size;
    update(['Size']);
  }

  void changeSelectedColor(Color color) {
    if (color == selectedColor) return;
    selectedColor = color;
    update(['Color']);
  }

  void incrementQuantity() {
    quantity++;
    update(['Quantity']);
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      update(['Quantity']);
    }
  }

  void onAddToCartPressed() {
    var mProduct = DummyHelper.products.firstWhere((p) => p.id == product.id);
    mProduct.quantity = (mProduct.quantity ?? 0) + quantity;
    mProduct.size = selectedSize;
    mProduct.selectedColor = selectedColor;

    try {
      Get.find<CartController>().getCartProducts();
      Get.find<BaseController>().refreshCartBadge();
    } catch (_) {}

    CustomSnackBar.showCustomSnackBar(
      title: 'Added to Bag',
      message: '${product.name} (x$quantity) added to your cart.',
    );

    Get.back();
  }
}
