import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/stripe_service.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  List<ProductModel> products = [];
  double subtotal = 0.0;
  double discount = 0.0;
  double grandTotal = 0.0;

  bool isPromoApplied = false;
  String appliedPromoCode = '';
  bool isCheckingOut = false;
  final TextEditingController promoTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCartProducts();
  }

  @override
  void onClose() {
    promoTextController.dispose();
    super.onClose();
  }

  /// Get the cart products from the product list
  void getCartProducts() {
    products = DummyHelper.products.where((p) => (p.quantity ?? 0) > 0).toList();
    _calculateTotals();
    update();
  }

  void _calculateTotals() {
    subtotal = products.fold<double>(
      0,
      (sum, item) => sum + (item.price ?? 0) * (item.quantity ?? 0),
    );

    if (isPromoApplied && subtotal > 0) {
      discount = subtotal * Constants.defaultPromoDiscount;
    } else {
      discount = 0.0;
    }

    grandTotal = (subtotal - discount).clamp(0.0, double.infinity);
  }

  /// Apply promo discount
  void applyPromoCode() {
    final inputCode = promoTextController.text.trim().toUpperCase();
    if (inputCode.isEmpty) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Empty Code',
        message: 'Please enter a promo code (try ${Constants.defaultPromoCode})',
      );
      return;
    }

    if (inputCode == Constants.defaultPromoCode) {
      isPromoApplied = true;
      appliedPromoCode = inputCode;
      _calculateTotals();
      update();
      CustomSnackBar.showCustomSnackBar(
        title: 'Promo Applied! 🎉',
        message: '20% discount applied to your order total.',
      );
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Invalid Code',
        message: 'Try using code "${Constants.defaultPromoCode}" for 20% off!',
      );
    }
  }

  void removePromoCode() {
    isPromoApplied = false;
    appliedPromoCode = '';
    promoTextController.clear();
    _calculateTotals();
    update();
  }

  /// When the user presses the increase button
  void onIncreasePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    product.quantity = (product.quantity ?? 0) + 1;
    getCartProducts();
    try {
      Get.find<BaseController>().refreshCartBadge();
    } catch (_) {}
    update(['ProductQuantity']);
  }

  /// When the user presses the decrease button
  void onDecreasePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    if ((product.quantity ?? 0) > 1) {
      product.quantity = (product.quantity ?? 0) - 1;
      getCartProducts();
      try {
        Get.find<BaseController>().refreshCartBadge();
      } catch (_) {}
      update(['ProductQuantity']);
    } else {
      onDeletePressed(productId);
    }
  }

  /// When the user presses the delete icon
  void onDeletePressed(int productId) {
    var product = DummyHelper.products.firstWhere((p) => p.id == productId);
    product.quantity = 0;
    getCartProducts();
    try {
      Get.find<BaseController>().refreshCartBadge();
    } catch (_) {}
  }

  /// When the user presses the purchase now button
  Future<void> onPurchaseNowPressed() async {
    if (isCheckingOut) return;
    if (products.isEmpty) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Empty Bag',
        message: 'Please add items to your bag before checking out.',
      );
      return;
    }

    isCheckingOut = true;
    update(['CheckoutButton']);

    try {
      final context = Get.context;
      if (context != null) {
        final isSuccess = await StripeService.instance.makePayment(
          amount: grandTotal,
          currency: 'usd',
          context: context,
        );

        if (isSuccess) {
          // Clear the cart products only after confirmed payment
          for (var product in DummyHelper.products) {
            product.quantity = 0;
          }
          isPromoApplied = false;
          appliedPromoCode = '';
          promoTextController.clear();

          getCartProducts();
          try {
            Get.find<BaseController>().refreshCartBadge();
            Get.find<BaseController>().changeScreen(0);
          } catch (_) {}
        }
      }
    } catch (e) {
      debugPrint('Payment error: $e');
    } finally {
      isCheckingOut = false;
      update(['CheckoutButton']);
    }
  }
}
