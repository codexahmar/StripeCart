import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/no_data.dart';
import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../controllers/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GetBuilder<FavoritesController>(
            builder: (controller) => ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                20.verticalSpace,
                ScreenTitle(
                  title: 'Wishlist',
                  subtitle: 'SAVED DROPS',
                  trailing: controller.products.isNotEmpty
                      ? GestureDetector(
                          onTap: controller.addAllToCart,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 14.r,
                                  color: theme.primaryColor,
                                ),
                                4.horizontalSpace,
                                Text(
                                  'Add All to Bag',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ).animate().fade().slideY(begin: -0.1, duration: const Duration(milliseconds: 300)),

                20.verticalSpace,

                controller.products.isEmpty
                    ? const NoData(
                        text: 'No Saved Drops Yet',
                        subtitle:
                            'Tap the heart icon on any drop to save it to your wishlist.',
                        buttonText: 'Browse Collection',
                      )
                    : GridView.builder(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14.w,
                          mainAxisSpacing: 14.h,
                          mainAxisExtent: 275.h,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(bottom: 100.h),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) => ProductItem(
                          product: controller.products[index],
                        ).animate().fade(duration: const Duration(milliseconds: 300)).slideY(
                              begin: 0.1,
                              duration: const Duration(milliseconds: 300),
                              delay: Duration(milliseconds: index * 50),
                            ),
                      ),
                10.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
