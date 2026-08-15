import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/base/controllers/base_controller.dart';
import 'custom_button.dart';

class NoData extends StatelessWidget {
  final String? text;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const NoData({
    super.key,
    this.text,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110.r,
              height: 110.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          theme.primaryColor.withValues(alpha: 0.25),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                        ]
                      : [
                          theme.primaryColor.withValues(alpha: 0.15),
                          const Color(0xFFEC4899).withValues(alpha: 0.05),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 48.r,
                  color: theme.primaryColor,
                ),
              ),
            ).animate().scale(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                ),
            24.verticalSpace,
            Text(
              text ?? 'No Items Found',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade().slideY(
                  begin: 0.2,
                  duration: const Duration(milliseconds: 400),
                ),
            8.verticalSpace,
            Text(
              subtitle ?? 'Explore our latest drops and discover your style.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF64748B),
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ).animate().fade().slideY(
                  begin: 0.2,
                  duration: const Duration(milliseconds: 400),
                  delay: const Duration(milliseconds: 100),
                ),
            24.verticalSpace,
            CustomButton(
              text: buttonText ?? 'Explore Catalog',
              width: 190.w,
              verticalPadding: 10.h,
              fontSize: 14.sp,
              onPressed: onButtonPressed ??
                  () {
                    try {
                      Get.find<BaseController>().changeScreen(0);
                    } catch (_) {}
                  },
            ).animate().fade().slideY(
                  begin: 0.3,
                  duration: const Duration(milliseconds: 400),
                  delay: const Duration(milliseconds: 200),
                ),
          ],
        ),
      ),
    );
  }
}
