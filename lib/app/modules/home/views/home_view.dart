import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/no_data.dart';
import '../../../components/product_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: GetBuilder<HomeController>(
          builder:
              (controller) => CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Top App Bar & Greeting
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.primaryColor,
                                      const Color(0xFFEC4899),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.primaryColor.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(2),
                                child: ClipOval(
                                  child: Image.asset(
                                    Constants.profilePhoto,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              12.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'WELCOME BACK',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  2.verticalSpace,
                                  Text(
                                    'Codex Ahmar',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: 44.r,
                            height: 44.r,
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? const Color(0xFF141C2E)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color:
                                    isDark
                                        ? const Color(0xFF1E293B)
                                        : const Color(0xFFE2E8F0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isDark
                                          ? Colors.black.withValues(alpha: 0.3)
                                          : const Color(
                                            0xFF64748B,
                                          ).withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SvgPicture.asset(
                                  Constants.notificationsIcon,
                                  width: 20.r,
                                  color:
                                      isDark
                                          ? Colors.white
                                          : const Color(0xFF0F172A),
                                ),
                                Positioned(
                                  top: 10.h,
                                  right: 10.w,
                                  child: Container(
                                    width: 8.r,
                                    height: 8.r,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF5376),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animate().fade().slideY(
                        begin: -0.2,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ),

                  // Search Bar
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color:
                              isDark ? const Color(0xFF141C2E) : Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color:
                                isDark
                                    ? const Color(0xFF1E293B)
                                    : const Color(0xFFE2E8F0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  isDark
                                      ? Colors.black.withValues(alpha: 0.2)
                                      : const Color(
                                        0xFF64748B,
                                      ).withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: controller.onSearchChanged,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color:
                                isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search luxury drops & styles...',
                            hintStyle: TextStyle(
                              fontSize: 13.sp,
                              color:
                                  isDark
                                      ? const Color(0xFF64748B)
                                      : const Color(0xFF94A3B8),
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color:
                                  isDark
                                      ? const Color(0xFF94A3B8)
                                      : const Color(0xFF64748B),
                              size: 22.r,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ).animate().fade().slideY(
                        begin: 0.1,
                        duration: const Duration(milliseconds: 350),
                      ),
                    ),
                  ),

                  // Large Hero Promotional Card with Prominent Big Product Image & CODEX20 code
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 185.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                                isDark
                                    ? [
                                      const Color(0xFF312E81),
                                      const Color(0xFF4C1D95),
                                      const Color(0xFF831843),
                                    ]
                                    : [
                                      const Color(0xFF4F46E5),
                                      const Color(0xFF7C3AED),
                                      const Color(0xFFDB2777),
                                    ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(26.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6366F1,
                              ).withValues(alpha: 0.4),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Promotional Text Content
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                top: 18.h,
                                bottom: 18.h,
                                right: 135.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 9.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.22,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.bolt_rounded,
                                          color: const Color(0xFFFBBF24),
                                          size: 14.r,
                                        ),
                                        4.horizontalSpace,
                                        Text(
                                          'CODEX SPECIAL DROP',
                                          style: TextStyle(
                                            fontSize: 9.5.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    'Cyber Edition\nCollection 2026',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.2,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  12.verticalSpace,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.15,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.discount_rounded,
                                          color: const Color(0xFF4F46E5),
                                          size: 14.r,
                                        ),
                                        6.horizontalSpace,
                                        Text(
                                          'CODE: CODEX20  (20% OFF)',
                                          style: TextStyle(
                                            fontSize: 8.5.sp,
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFF4F46E5),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Prominent, Large Product Image overflowing
                            Positioned(
                              right: -5.w,
                              bottom: -17.h,
                              top: -10.h,
                              child: SizedBox(
                                width: 145.w,
                                child: Image.asset(
                                  Constants.product1,
                                  fit: BoxFit.contain,
                                ).animate().scale(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOutBack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fade().slideY(
                        begin: 0.1,
                        duration: const Duration(milliseconds: 400),
                      ),
                    ),
                  ),

                  // Categories Horizontal Bar (Instant, crisp switching)
                  SliverPadding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                    sliver: SliverToBoxAdapter(
                      child: SizedBox(
                        height: 42.h,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: Constants.categories.length,
                          separatorBuilder: (_, __) => 10.horizontalSpace,
                          itemBuilder: (context, index) {
                            final category = Constants.categories[index];
                            final isSelected =
                                controller.selectedCategory == category;

                            return GestureDetector(
                              onTap: () => controller.changeCategory(category),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 9.h,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? theme.primaryColor
                                          : (isDark
                                              ? const Color(0xFF141C2E)
                                              : Colors.white),
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? theme.primaryColor
                                            : (isDark
                                                ? const Color(0xFF1E293B)
                                                : const Color(0xFFE2E8F0)),
                                    width: 1.2,
                                  ),
                                  boxShadow:
                                      isSelected
                                          ? [
                                            BoxShadow(
                                              color: theme.primaryColor
                                                  .withValues(alpha: 0.35),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                          : null,
                                ),
                                child: Center(
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : (isDark
                                                  ? const Color(0xFF94A3B8)
                                                  : const Color(0xFF64748B)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Section Title Header
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 8.h,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Featured Drops',
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              8.horizontalSpace,
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  '${controller.filteredProducts.length}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w800,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'SEE ALL',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: theme.primaryColor,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Balanced, Clean High-End 2-Column Luxury Drop Grid
                  controller.filteredProducts.isEmpty
                      ? const SliverToBoxAdapter(
                        child: NoData(
                          text: 'No Matching Drops Found',
                          subtitle:
                              'Try searching with different keywords or categories.',
                        ),
                      )
                      : SliverPadding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 6.h,
                          bottom: 120.h,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14.w,
                                mainAxisSpacing: 14.h,
                                mainAxisExtent: 275.h,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final product = controller.filteredProducts[index];
                            return ProductItem(product: product)
                                .animate()
                                .fade(
                                  duration: const Duration(milliseconds: 300),
                                )
                                .slideY(
                                  begin: 0.1,
                                  duration: const Duration(milliseconds: 300),
                                  delay: Duration(milliseconds: index * 40),
                                );
                          }, childCount: controller.filteredProducts.length),
                        ),
                      ),
                ],
              ),
        ),
      ),
    );
  }
}
