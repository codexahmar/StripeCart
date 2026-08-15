import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double? size;
  final Color? backgroundColor;

  const RoundedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.size,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.brightness == Brightness.dark;
    final buttonSize = size ?? 44.r;

    return ClipRRect(
      borderRadius: BorderRadius.circular(buttonSize / 2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ??
                (isDark
                    ? const Color(0xFF141C2E).withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.85)),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.12)
                  : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(buttonSize / 2),
              onTap: onPressed,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
