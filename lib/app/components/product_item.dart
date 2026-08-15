import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../../utils/dummy_helper.dart';
import '../data/models/product_model.dart';
import '../modules/base/controllers/base_controller.dart';
import '../modules/cart/controllers/cart_controller.dart';
import '../routes/app_pages.dart';
import 'custom_snackbar.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final double? imageHeight;

  const ProductItem({
    super.key,
    required this.product,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF141C2E) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isDark
                ? const Color(0xFF1E293B)
                : const Color(0xFFE2E8F0).withValues(alpha: 0.8),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : const Color(0xFF64748B).withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Stack Container
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: imageHeight ?? 142.h,
                  margin: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B).withValues(alpha: 0.6)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Image.asset(
                          product.image!,
                          fit: BoxFit.contain,
                        ).animate().scale(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            ),
                      ),
                    ),
                  ),
                ),

                // Tag / Discount Badge
                if (product.discountPercent != null || product.tag != null)
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: product.tag == 'HOT DROP'
                              ? [const Color(0xFFFF5376), const Color(0xFFFF8B3D)]
                              : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF5376).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        product.tag ?? '-${product.discountPercent}%',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                // Favorite Button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GetBuilder<BaseController>(
                    id: 'FavoriteButton',
                    builder: (baseController) {
                      final isFav = product.isFavorite ?? false;
                      return GestureDetector(
                        onTap: () => baseController.onFavoriteButtonPressed(
                          productId: product.id!,
                        ),
                        child: Container(
                          width: 30.r,
                          height: 30.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xFF0F172A).withValues(alpha: 0.85)
                                : Colors.white.withValues(alpha: 0.95),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              isFav
                                  ? Constants.favFilledIcon
                                  : Constants.favOutlinedIcon,
                              width: 13.r,
                              height: 13.r,
                              color: isFav
                                  ? const Color(0xFFFF5376)
                                  : (isDark
                                      ? const Color(0xFF94A3B8)
                                      : const Color(0xFF64748B)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Product Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand Name
                  if (product.brand != null)
                    Text(
                      product.brand!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                        letterSpacing: 0.8,
                      ),
                    ),

                  1.verticalSpace,

                  // Product Title
                  Text(
                    product.name ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  3.verticalSpace,

                  // Rating Row
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF59E0B),
                        size: 14,
                      ),
                      3.horizontalSpace,
                      Text(
                        '${product.rating ?? 4.5}',
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        '(${product.reviews ?? '1k'})',
                        style: TextStyle(
                          fontSize: 9.5.sp,
                          color: isDark
                              ? const Color(0xFF64748B)
                              : const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),

                  6.verticalSpace,

                  // Price and Quick Add Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.oldPrice != null)
                            Text(
                              '\$${product.oldPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF94A3B8),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            '\$${product.price!.toStringAsFixed(2)}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),

                      // Quick Add to Cart button
                      GestureDetector(
                        onTap: () {
                          var mProduct = DummyHelper.products
                              .firstWhere((p) => p.id == product.id);
                          mProduct.quantity = (mProduct.quantity ?? 0) + 1;
                          mProduct.size ??= 'M';
                          try {
                            Get.find<CartController>().getCartProducts();
                          } catch (_) {}
                          CustomSnackBar.showCustomSnackBar(
                            title: 'Added to Bag',
                            message: '${product.name} added to cart',
                          );
                        },
                        child: Container(
                          width: 30.r,
                          height: 30.r,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                isDark
                                    ? const Color(0xFF8B5CF6)
                                    : const Color(0xFF4F46E5),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(9.r),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withValues(alpha: 0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
