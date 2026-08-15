import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: 120.h,
          ),
          children: [
            const ScreenTitle(
              title: 'Profile & Settings',
              subtitle: 'ACCOUNT',
            ).animate().fade().slideY(begin: -0.1, duration: const Duration(milliseconds: 300)),

            20.verticalSpace,

            // Profile Card
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          const Color(0xFF1E1B4B),
                          const Color(0xFF141C2E),
                        ]
                      : [
                          const Color(0xFFEEF2FF),
                          Colors.white,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.25),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 62.r,
                    height: 62.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor,
                          const Color(0xFFEC4899),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(2.5),
                    child: ClipOval(
                      child: Image.asset(
                        Constants.profilePhoto,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  14.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Codex Ahmar',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            6.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFF59E0B),
                                    Color(0xFFFF8B3D),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'VIP ELITE',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        4.verticalSpace,
                        Text(
                          'codexahmar@gmail.com',
                          style: TextStyle(
                            fontSize: 12.sp,
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
            ).animate().fade().slideY(begin: 0.1, duration: const Duration(milliseconds: 350)),

            24.verticalSpace,

            // Preferences Section
            _sectionHeader('PREFERENCES', theme),
            10.verticalSpace,
            const SettingsItem(
              title: 'Dark Mode',
              subtitle: 'Switch between dark and light aesthetics',
              icon: Constants.themeIcon,
              isDarkToggle: true,
            ),
            SettingsItem(
              title: 'Currency',
              subtitle: 'Default transaction currency',
              icon: Constants.busIcon,
              valueText: 'USD (\$)',
              onTap: () {
                CustomSnackBar.showCustomToast(
                  message: 'Default store currency set to USD (\$)',
                );
              },
            ),
            SettingsItem(
              title: 'Language',
              subtitle: 'Display and localized language',
              icon: Constants.languageIcon,
              valueText: 'English (US)',
              onTap: () {
                CustomSnackBar.showCustomToast(
                  message: 'App language is set to English',
                );
              },
            ),

            20.verticalSpace,

            // Account & Payment Section
            _sectionHeader('ACCOUNT & SECURITY', theme),
            10.verticalSpace,
            SettingsItem(
              title: 'Stripe Payment Methods',
              subtitle: 'Credit cards, Apple Pay & Google Pay',
              icon: Constants.cartIcon,
              onTap: () {
                CustomSnackBar.showCustomToast(
                  message: 'Stripe is connected for secure checkout',
                );
              },
            ),
            SettingsItem(
              title: 'Shipping Addresses',
              subtitle: 'Manage saved delivery destinations',
              icon: Constants.busIcon,
              onTap: () {
                CustomSnackBar.showCustomToast(
                  message: '1 address saved: 742 Evergreen Terrace',
                );
              },
            ),

            20.verticalSpace,

            // Support Section
            _sectionHeader('SUPPORT & LEGAL', theme),
            10.verticalSpace,
            SettingsItem(
              title: 'Customer Support & FAQ',
              subtitle: '24/7 VIP concierge assistance',
              icon: Constants.helpIcon,
              onTap: () {
                CustomSnackBar.showCustomToast(
                  message: 'Support team available 24/7 at support@stripecart.io',
                );
              },
            ),
            SettingsItem(
              title: 'Sign Out',
              subtitle: 'Log out of this device',
              icon: Constants.logoutIcon,
              iconColor: const Color(0xFFEF4444),
              onTap: () {
                CustomSnackBar.showCustomToast(
                  title: 'Sign Out',
                  message: 'Signed out successfully.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
