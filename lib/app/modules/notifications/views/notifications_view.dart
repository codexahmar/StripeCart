import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/screen_title.dart';
import '../controllers/notifications_controller.dart';
import 'widgets/notification_item.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: GetBuilder<NotificationsController>(
            builder: (controller) => ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 100.h),
              children: [
                20.verticalSpace,
                ScreenTitle(
                  title: 'Activity',
                  subtitle: 'NOTIFICATIONS',
                  trailing: GestureDetector(
                    onTap: controller.markAllAsRead,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Mark all read',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ).animate().fade().slideY(begin: -0.1, duration: const Duration(milliseconds: 300)),

                20.verticalSpace,

                ...controller.notifications.asMap().entries.map((entry) {
                  final index = entry.key;
                  final notification = entry.value;
                  return NotificationItem(notification: notification)
                      .animate()
                      .fade(duration: const Duration(milliseconds: 250))
                      .slideY(
                        begin: 0.1,
                        duration: const Duration(milliseconds: 250),
                        delay: Duration(milliseconds: index * 40),
                      );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
