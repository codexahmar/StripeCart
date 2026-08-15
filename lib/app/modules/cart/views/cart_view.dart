import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/custom_button.dart';
import '../../../components/no_data.dart';
import '../../../components/screen_title.dart';
import '../controllers/cart_controller.dart';
import 'widgets/cart_item.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: GetBuilder<CartController>(
          builder: (controller) => controller.products.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.verticalSpace,
                      const ScreenTitle(
                        title: 'Shopping Bag',
                        subtitle: 'CHECKOUT',
                      ),
                      Expanded(
                        child: const NoData(
                          text: 'Your Shopping Bag is Empty',
                          subtitle:
                              'Discover our curated selection of high-end streetwear and accessories.',
                          buttonText: 'Start Shopping',
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 20.h,
                    bottom: 120.h,
                  ),
                  children: [
                    // Header
                    ScreenTitle(
                      title: 'Shopping Bag',
                      subtitle: 'CHECKOUT',
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${controller.products.length} Items',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ).animate().fade().slideY(begin: -0.1, duration: const Duration(milliseconds: 300)),

                    20.verticalSpace,

                    // Cart Items List
                    ...controller.products.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return CartItem(product: item)
                          .animate()
                          .fade(duration: const Duration(milliseconds: 250))
                          .slideX(
                            begin: -0.05,
                            duration: const Duration(milliseconds: 250),
                            delay: Duration(milliseconds: index * 40),
                          );
                    }),

                    12.verticalSpace,

                    // Promo Code Input Card
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF141C2E) : Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.promoTextController,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF0F172A),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Promo code (try CODEX20)',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0,
                                      color: isDark
                                          ? const Color(0xFF64748B)
                                          : const Color(0xFF94A3B8),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.discount_outlined,
                                      color: theme.primaryColor,
                                      size: 20.r,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                    ),
                                  ),
                                ),
                              ),
                              8.horizontalSpace,
                              CustomButton(
                                text: controller.isPromoApplied
                                    ? 'Applied'
                                    : 'Apply',
                                width: 85.w,
                                verticalPadding: 8.h,
                                fontSize: 12.sp,
                                disabled: controller.isPromoApplied,
                                onPressed: controller.applyPromoCode,
                              ),
                            ],
                          ),
                          if (controller.isPromoApplied) ...[
                            8.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_rounded,
                                      color: Color(0xFF10B981),
                                      size: 16,
                                    ),
                                    6.horizontalSpace,
                                    Text(
                                      'Code "${controller.appliedPromoCode}" Active (20% OFF)',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: controller.removePromoCode,
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFFEF4444),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    16.verticalSpace,

                    // Order Summary Breakdown Card
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF141C2E) : Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.2)
                                : const Color(0xFF64748B).withValues(alpha: 0.05),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _summaryRow(
                            label: 'Subtotal',
                            value:
                                '\$${controller.subtotal.toStringAsFixed(2)}',
                            isDark: isDark,
                          ),
                          if (controller.isPromoApplied) ...[
                            10.verticalSpace,
                            _summaryRow(
                              label: 'Promo Discount (20%)',
                              value:
                                  '-\$${controller.discount.toStringAsFixed(2)}',
                              isDark: isDark,
                              isDiscount: true,
                            ),
                          ],
                          10.verticalSpace,
                          _summaryRow(
                            label: 'Express Shipping',
                            value: 'FREE',
                            isDark: isDark,
                            isFree: true,
                          ),
                          14.verticalSpace,
                          Divider(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFE2E8F0),
                          ),
                          14.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '\$${controller.grandTotal.toStringAsFixed(2)}',
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    24.verticalSpace,

                    // Checkout CTA Button
                    CustomButton(
                      text:
                          'Pay with Stripe • \$${controller.grandTotal.toStringAsFixed(2)}',
                      icon: const Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: controller.onPurchaseNowPressed,
                      fontSize: 16.sp,
                      verticalPadding: 16.h,
                    ).animate().scale(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutBack,
                        ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _summaryRow({
    required String label,
    required String value,
    required bool isDark,
    bool isDiscount = false,
    bool isFree = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: isDiscount
                ? const Color(0xFF10B981)
                : isFree
                    ? const Color(0xFF6366F1)
                    : (isDark ? Colors.white : const Color(0xFF0F172A)),
          ),
        ),
      ],
    );
  }
}
