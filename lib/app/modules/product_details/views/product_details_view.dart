import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'widgets/rounded_button.dart';
import 'widgets/size_item.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final product = controller.product;

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 120.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dynamic Hero Image Showcase reacting to color & size
                GetBuilder<ProductDetailsController>(
                  id: 'HeroContainer',
                  builder: (ctrl) {
                    final activeColor = ctrl.selectedColor ?? theme.primaryColor;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOut,
                      width: double.infinity,
                      height: 380.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [
                                  activeColor.withValues(alpha: 0.28),
                                  const Color(0xFF141C2E),
                                ]
                              : [
                                  activeColor.withValues(alpha: 0.22),
                                  const Color(0xFFF1F5F9),
                                ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36.r),
                          bottomRight: Radius.circular(36.r),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Dynamic glowing orb matching selected color
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            width: 220.r,
                            height: 220.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: activeColor.withValues(
                                alpha: isDark ? 0.35 : 0.22,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: activeColor.withValues(
                                    alpha: isDark ? 0.45 : 0.25,
                                  ),
                                  blurRadius: 90,
                                  spreadRadius: 25,
                                ),
                              ],
                            ),
                          ),

                          // Product Hero Image dynamically scaling with selected size!
                          GetBuilder<ProductDetailsController>(
                            id: 'HeroImage',
                            builder: (scaleCtrl) => AnimatedScale(
                              scale: scaleCtrl.sizeScale,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: Hero(
                                tag: 'product_${product.id}',
                                child: Image.asset(
                                  product.image!,
                                  height: 280.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          // Discount Tag Floating
                          if (product.tag != null)
                            Positioned(
                              bottom: 20.h,
                              left: 24.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF5376),
                                      Color(0xFFFF8B3D),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFFF5376).withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  product.tag!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),

                20.verticalSpace,

                // Product Details Container
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand & Category
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (product.brand ?? 'EXCLUSIVE DROP').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                              color: theme.primaryColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFEEF2FF),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              product.category ?? 'Apparel',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fade().slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),

                      8.verticalSpace,

                      // Product Title
                      Text(
                        product.name!,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ).animate().fade().slideX(begin: -0.1, duration: const Duration(milliseconds: 350)),

                      12.verticalSpace,

                      // Rating & Reviews Row
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFF59E0B),
                                  size: 18,
                                ),
                                4.horizontalSpace,
                                Text(
                                  '${product.rating ?? 4.8}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFFF59E0B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          10.horizontalSpace,
                          Text(
                            '${product.reviews ?? '1.2k'} customer reviews',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ).animate().fade().slideX(begin: -0.1, duration: const Duration(milliseconds: 400)),

                      16.verticalSpace,

                      // Price Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '\$${product.price!.toStringAsFixed(2)}',
                            style: theme.textTheme.displayLarge?.copyWith(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: theme.primaryColor,
                            ),
                          ),
                          if (product.oldPrice != null) ...[
                            12.horizontalSpace,
                            Text(
                              '\$${product.oldPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xFF94A3B8),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ).animate().fade().slideX(begin: -0.1, duration: const Duration(milliseconds: 450)),

                      20.verticalSpace,
                      Divider(color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
                      16.verticalSpace,

                      // Interactive Color Swatches Selector
                      if (product.availableColors != null &&
                          product.availableColors!.isNotEmpty) ...[
                        Text(
                          'SELECT COLOR (TAP TO PREVIEW TINT)',
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                        ),
                        10.verticalSpace,
                        GetBuilder<ProductDetailsController>(
                          id: 'Color',
                          builder: (controller) => Row(
                            children: product.availableColors!.map((color) {
                              final isSelected =
                                  controller.selectedColor == color;
                              return GestureDetector(
                                onTap: () =>
                                    controller.changeSelectedColor(color),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: EdgeInsets.only(right: 12.w),
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? color
                                          : Colors.transparent,
                                      width: 2.2,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: color.withValues(alpha: 0.4),
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Container(
                                    width: 32.r,
                                    height: 32.r,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        20.verticalSpace,
                      ],

                      // Interactive Size Selector (Resizes fitting preview!)
                      Text(
                        'SELECT SIZE (RESIZES FITTING PREVIEW)',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                      10.verticalSpace,
                      GetBuilder<ProductDetailsController>(
                        id: 'Size',
                        builder: (controller) => Row(
                          children: ['S', 'M', 'L', 'XL', 'XXL'].map((size) {
                            return Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: SizeItem(
                                label: size,
                                selected: controller.selectedSize == size,
                                onPressed: () =>
                                    controller.changeSelectedSize(size),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      24.verticalSpace,

                      // Description Section
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        product.description ??
                            'Engineered with premium sustainable fabrics, designed with modern minimalist aesthetics and reinforced structural stitching.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          height: 1.6,
                          color: isDark
                              ? const Color(0xFFCBD5E1)
                              : const Color(0xFF475569),
                        ),
                      ),

                      20.verticalSpace,

                      // Feature Badges
                      Container(
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF141C2E)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _featureBadge(
                              icon: Icons.verified_rounded,
                              label: '100% Authentic',
                              theme: theme,
                              isDark: isDark,
                            ),
                            _featureBadge(
                              icon: Icons.local_shipping_rounded,
                              label: 'Free Express',
                              theme: theme,
                              isDark: isDark,
                            ),
                            _featureBadge(
                              icon: Icons.replay_rounded,
                              label: '30-Day Return',
                              theme: theme,
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Top Navigation Bar
          Positioned(
            top: 40.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  onPressed: () => Get.back(),
                  child: SvgPicture.asset(
                    Constants.backArrowIcon,
                    width: 18.r,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                GetBuilder<ProductDetailsController>(
                  id: 'FavoriteButton',
                  builder: (ctrl) {
                    final isFav = ctrl.product.isFavorite ?? false;
                    return RoundedButton(
                      onPressed: ctrl.onFavoriteButtonPressed,
                      child: SvgPicture.asset(
                        isFav
                            ? Constants.favFilledIcon
                            : Constants.favOutlinedIcon,
                        width: 18.r,
                        color: isFav
                            ? const Color(0xFFFF5376)
                            : (isDark
                                ? Colors.white
                                : const Color(0xFF0F172A)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Sticky Bottom Glass Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF0B0F19).withValues(alpha: 0.88)
                        : Colors.white.withValues(alpha: 0.90),
                    border: Border(
                      top: BorderSide(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Quantity Stepper
                      GetBuilder<ProductDetailsController>(
                        id: 'Quantity',
                        builder: (controller) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF141C2E)
                                : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xFF1E293B)
                                  : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                constraints: BoxConstraints(
                                  minWidth: 32.w,
                                  minHeight: 32.h,
                                ),
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.remove_rounded,
                                  size: 18.r,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0F172A),
                                ),
                                onPressed: controller.decrementQuantity,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  '${controller.quantity}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              IconButton(
                                constraints: BoxConstraints(
                                  minWidth: 32.w,
                                  minHeight: 32.h,
                                ),
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 18.r,
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xFF0F172A),
                                ),
                                onPressed: controller.incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                      ),

                      14.horizontalSpace,

                      // Add to Cart Button
                      Expanded(
                        child: CustomButton(
                          text: 'Add to Bag',
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: controller.onAddToCartPressed,
                          fontSize: 15.sp,
                          verticalPadding: 14.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureBadge({
    required IconData icon,
    required String label,
    required ThemeData theme,
    required bool isDark,
  }) {
    return Column(
      children: [
        Icon(icon, color: theme.primaryColor, size: 22.r),
        4.verticalSpace,
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
