import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isDark
                    ? [
                      const Color(0xFF0B0F19),
                      const Color(0xFF1E1B4B),
                      const Color(0xFF0B0F19),
                    ]
                    : [
                      const Color(0xFFF8FAFC),
                      const Color(0xFFEEF2FF),
                      const Color(0xFFF8FAFC),
                    ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main Brand Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Floating Glass Logo Card
                Container(
                      width: 110.r,
                      height: 110.r,
                      padding: EdgeInsets.all(22.r),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? const Color(0xFF141C2E).withValues(alpha: 0.8)
                                : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(30.r),
                        border: Border.all(
                          color: theme.primaryColor.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primaryColor.withValues(alpha: 0.3),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Image.asset(Constants.logo, fit: BoxFit.contain),
                    )
                    .animate()
                    .scale(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutBack,
                    )
                    .shimmer(
                      duration: const Duration(milliseconds: 1400),
                      delay: const Duration(milliseconds: 600),
                      color: Colors.white.withValues(alpha: 0.4),
                    ),

                28.verticalSpace,

                // Brand Name
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'STRIPE',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color: theme.primaryColor,
                          ),
                        ),
                        Text(
                          'CART',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color:
                                isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 500))
                    .slideY(
                      begin: 0.3,
                      duration: const Duration(milliseconds: 500),
                    ),

                10.verticalSpace,

                // Slogan / Subtitle
                Text(
                      'NEXT-GEN LUXURY COMMERCE',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.0,
                        color:
                            isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                      ),
                    )
                    .animate()
                    .fade(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500),
                    )
                    .slideY(
                      begin: 0.3,
                      duration: const Duration(milliseconds: 500),
                    ),

                60.verticalSpace,

                // Bottom loading bar
                Container(
                      width: 140.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 60.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                const Color(0xFFEC4899),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: const Duration(milliseconds: 1000),
                      color: Colors.white,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
