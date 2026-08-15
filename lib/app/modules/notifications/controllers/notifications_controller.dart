import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconColor;
  final String tag;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.tag,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      title: 'Order Dispatched #4829',
      message: 'Your Cyber Oversized Tee has left the warehouse with FedEx Express.',
      time: '10 min ago',
      icon: Icons.local_shipping_rounded,
      iconColor: const Color(0xFF6366F1),
      tag: 'SHIPPED',
      isRead: false,
    ),
    NotificationModel(
      id: 2,
      title: 'Exclusive VIP Drop Live 🔥',
      message: 'Tokyo Archive raw selvedge denim collection is now available for VIP members.',
      time: '2 hours ago',
      icon: Icons.local_fire_department_rounded,
      iconColor: const Color(0xFFFF5376),
      tag: 'HOT DROP',
      isRead: false,
    ),
    NotificationModel(
      id: 3,
      title: 'Stripe Payment Confirmed',
      message: 'Payment of \$89.99 was successfully processed for Matrix Asymmetric Skirt.',
      time: 'Yesterday',
      icon: Icons.check_circle_rounded,
      iconColor: const Color(0xFF10B981),
      tag: 'SUCCESS',
      isRead: true,
    ),
    NotificationModel(
      id: 4,
      title: 'Weekend Flash Sale ⚡',
      message: 'Unlock 20% off with promo code INSTA20 on your next checkout.',
      time: '2 days ago',
      icon: Icons.bolt_rounded,
      iconColor: const Color(0xFFF59E0B),
      tag: 'PROMO',
      isRead: true,
    ),
    NotificationModel(
      id: 5,
      title: 'Package Delivered 📦',
      message: 'Order #3910 was securely delivered to your designated address.',
      time: '3 days ago',
      icon: Icons.inventory_2_rounded,
      iconColor: const Color(0xFF06B6D4),
      tag: 'DELIVERED',
      isRead: true,
    ),
  ];

  void markAllAsRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    update();
  }
}
