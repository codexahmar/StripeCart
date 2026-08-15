import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../controllers/base_controller.dart';
import '../../cart/views/cart_view.dart';
import '../../favorites/views/favorites_view.dart';
import '../../home/views/home_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../settings/views/settings_view.dart';

class BaseView extends GetView<BaseController> {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<BaseController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: controller.currentIndex,
            children: const [
              HomeView(),
              FavoritesView(),
              CartView(),
              NotificationsView(),
              SettingsView(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 18.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                height: 68.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF141C2E).withValues(alpha: 0.85)
                      : Colors.white.withValues(alpha: 0.90),
                  borderRadius: BorderRadius.circular(28.r),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : theme.primaryColor.withValues(alpha: 0.12),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.4)
                          : const Color(0xFF6366F1).withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      index: 0,
                      label: 'Home',
                      icon: Constants.homeIcon,
                      isActive: controller.currentIndex == 0,
                      onTap: () => controller.changeScreen(0),
                      theme: theme,
                      isDark: isDark,
                    ),
                    _navItem(
                      index: 1,
                      label: 'Saved',
                      icon: Constants.favoritesIcon,
                      isActive: controller.currentIndex == 1,
                      onTap: () => controller.changeScreen(1),
                      theme: theme,
                      isDark: isDark,
                    ),
                    _navItem(
                      index: 2,
                      label: 'Bag',
                      icon: Constants.cartIcon,
                      isActive: controller.currentIndex == 2,
                      onTap: () => controller.changeScreen(2),
                      theme: theme,
                      isDark: isDark,
                      badgeCount: controller.cartCount,
                    ),
                    _navItem(
                      index: 3,
                      label: 'Alerts',
                      icon: Constants.notificationsIcon,
                      isActive: controller.currentIndex == 3,
                      onTap: () => controller.changeScreen(3),
                      theme: theme,
                      isDark: isDark,
                    ),
                    _navItem(
                      index: 4,
                      label: 'Profile',
                      icon: Constants.settingsIcon,
                      isActive: controller.currentIndex == 4,
                      onTap: () => controller.changeScreen(4),
                      theme: theme,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required String label,
    required String icon,
    required bool isActive,
    required VoidCallback onTap,
    required ThemeData theme,
    required bool isDark,
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 14.w : 10.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [
                    theme.primaryColor,
                    isDark
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF4F46E5),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 20.r,
                  height: 20.r,
                  color: isActive
                      ? Colors.white
                      : (isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B)),
                ),
                if (isActive) ...[
                  6.horizontalSpace,
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
            if (badgeCount > 0 && !isActive)
              Positioned(
                top: -6.h,
                right: -8.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5376),
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16.r,
                    minHeight: 16.r,
                  ),
                  child: Center(
                    child: Text(
                      badgeCount > 9 ? '9+' : '$badgeCount',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
