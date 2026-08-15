import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? radius;
  final double? fontSize;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final FontWeight? fontWeight;
  final double? spacing;
  final Widget? icon;
  final Widget? trailingIcon;
  final Color? borderColor;
  final bool hasShadow;
  final Color? shadowColor;
  final double shadowOpacity;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final double? width;
  final double? height;
  final double? verticalPadding;
  final bool disabled;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.radius,
    this.fontSize,
    this.gradient,
    this.fontWeight,
    this.spacing,
    this.icon,
    this.trailingIcon,
    this.borderColor,
    this.hasShadow = true,
    this.shadowColor,
    this.shadowOpacity = 0.35,
    this.shadowBlurRadius = 16,
    this.shadowSpreadRadius = 0,
    this.width,
    this.height,
    this.verticalPadding,
    this.disabled = false,
    this.isLoading = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.primaryColor;

    final effectiveRadius = BorderRadius.circular(widget.radius ?? 14.r);
    final effectiveGradient = widget.gradient ??
        (!widget.disabled && widget.backgroundColor == null
            ? LinearGradient(
                colors: isDark
                    ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
                    : [const Color(0xFF4F46E5), const Color(0xFF6366F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null);

    final effectiveShadowColor =
        widget.shadowColor ?? (widget.backgroundColor ?? primary);

    return AnimatedScale(
      scale: _isPressed && !widget.disabled ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: effectiveRadius,
          boxShadow: widget.hasShadow && !widget.disabled
              ? [
                  BoxShadow(
                    color: effectiveShadowColor.withValues(
                      alpha: widget.shadowOpacity,
                    ),
                    blurRadius: widget.shadowBlurRadius,
                    spreadRadius: widget.shadowSpreadRadius,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: effectiveRadius,
          child: InkWell(
            borderRadius: effectiveRadius,
            splashColor: Colors.white.withValues(alpha: 0.15),
            highlightColor: Colors.white.withValues(alpha: 0.05),
            onHighlightChanged: (value) {
              setState(() => _isPressed = value);
            },
            onTap: !widget.disabled && !widget.isLoading
                ? widget.onPressed
                : null,
            child: Ink(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: widget.verticalPadding ?? 14.h,
              ),
              decoration: BoxDecoration(
                borderRadius: effectiveRadius,
                border: Border.all(
                  color: widget.borderColor ?? Colors.transparent,
                  width: 1.2,
                ),
                gradient: widget.disabled ? null : effectiveGradient,
                color: widget.disabled
                    ? (isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFE2E8F0))
                    : widget.backgroundColor,
              ),
              child: Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.icon != null) ...[
                            widget.icon!,
                            SizedBox(width: widget.spacing ?? 8.w),
                          ],
                          Text(
                            widget.text,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontSize: widget.fontSize ?? 15.sp,
                              fontWeight:
                                  widget.fontWeight ?? FontWeight.w700,
                              color: widget.disabled
                                  ? (isDark
                                      ? const Color(0xFF64748B)
                                      : const Color(0xFF94A3B8))
                                  : (widget.foregroundColor ?? Colors.white),
                              letterSpacing: 0.3,
                            ),
                          ),
                          if (widget.trailingIcon != null) ...[
                            SizedBox(width: widget.spacing ?? 8.w),
                            widget.trailingIcon!,
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
