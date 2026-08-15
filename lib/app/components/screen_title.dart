import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double? dividerEndIndent;

  const ScreenTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.dividerEndIndent,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (subtitle != null) ...[
                  Text(
                    subtitle!.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.primaryColor,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  4.verticalSpace,
                ],
                Text(
                  title,
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
        8.verticalSpace,
        Container(
          width: 48.w,
          height: 4.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.r),
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                isDark ? const Color(0xFF8B5CF6) : const Color(0xFFEC4899),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
