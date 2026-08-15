import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/notifications_controller.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141C2E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: notification.isRead
              ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))
              : theme.primaryColor.withValues(alpha: 0.4),
          width: notification.isRead ? 1.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : const Color(0xFF64748B).withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: notification.iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Center(
              child: Icon(
                notification.icon,
                color: notification.iconColor,
                size: 24.r,
              ),
            ),
          ),

          12.horizontalSpace,

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: notification.iconColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        notification.tag,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: notification.iconColor,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          notification.time,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDark
                                ? const Color(0xFF64748B)
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                        if (!notification.isRead) ...[
                          6.horizontalSpace,
                          Container(
                            width: 7.r,
                            height: 7.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                6.verticalSpace,

                // Title
                Text(
                  notification.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                4.verticalSpace,

                // Description
                Text(
                  notification.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: isDark
                        ? const Color(0xFF94A3B8)
                        : const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
