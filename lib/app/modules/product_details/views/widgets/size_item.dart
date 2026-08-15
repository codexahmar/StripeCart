import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SizeItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool selected;

  const SizeItem({
    super.key,
    required this.onPressed,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 48.r,
        height: 48.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: selected
              ? LinearGradient(
                  colors: [
                    theme.primaryColor,
                    isDark
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFF4F46E5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected
              ? null
              : (isDark ? const Color(0xFF141C2E) : Colors.white),
          border: Border.all(
            color: selected
                ? Colors.transparent
                : (isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFE2E8F0)),
            width: 1.2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected
                  ? Colors.white
                  : (isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF334155)),
            ),
          ),
        ),
      ),
    );
  }
}
