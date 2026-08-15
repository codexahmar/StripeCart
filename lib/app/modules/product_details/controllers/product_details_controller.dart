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

  double get sizeScale {
    switch (selectedSize) {
      case 'S':
        return 0.86;
      case 'M':
        return 0.95;
      case 'L':
        return 1.05;
      case 'XL':
        return 1.13;
      case 'XXL':
        return 1.20;
      default:
        return 0.95;
    }
  }

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
    Get.find<BaseController>().onFavoriteButtonPressed(productId: product.id!);
    var updated = DummyHelper.products.firstWhere((p) => p.id == product.id);
    product.isFavorite = updated.isFavorite;
    update(['FavoriteButton']);
  }

  void changeSelectedSize(String size) {
    if (size == selectedSize) return;
    selectedSize = size;
    update(['Size', 'HeroImage']);
  }

  void changeSelectedColor(Color color) {
    if (color == selectedColor) return;
    selectedColor = color;
    update(['Color', 'HeroContainer']);
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
