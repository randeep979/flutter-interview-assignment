import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.4, -0.6),
          radius: 1.5,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              
              // Screen Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Settings List
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                  children: [
                    _buildSettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: "Edit Profile",
                      subtitle: "Manage your professional profile",
                    ),
                    _buildSettingsTile(
                      icon: Icons.manage_accounts_outlined,
                      title: "Account",
                      subtitle: "Manage account and login settings",
                    ),
                    _buildSettingsTile(
                      icon: Icons.notifications_none_rounded,
                      title: "Notification",
                      subtitle: "Manage your notification preferences",
                    ),
                    _buildSettingsTile(
                      icon: Icons.palette_outlined,
                      title: "Appearance",
                      subtitle: "Customize your app experience",
                    ),
                    _buildSettingsTile(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: "Help & Feedback",
                      subtitle: "Get help or share feedback",
                    ),
                    _buildSettingsTile(
                      icon: Icons.person_add_alt_1_outlined,
                      title: "Invite a friend",
                      subtitle: "Invite friends to NextRole.app",
                    ),
                    _buildSettingsTile(
                      icon: Icons.admin_panel_settings_outlined,
                      title: "Privacy & Security",
                      subtitle: "Manage privacy and data settings",
                    ),
                    _buildSettingsTile(
                      icon: Icons.credit_card_rounded,
                      title: "Subscription",
                      subtitle: "Manage your plan and billing",
                      hasBadge: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool hasBadge = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              // Action handler
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Icon container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.textPrimary.withOpacity(0.05),
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.textPrimary.withOpacity(0.8),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  
                  // Text fields
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // Badge or Chevron
                  if (hasBadge)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.badgeGoldBackground.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.accentYellow.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        "Coming Soon",
                        style: TextStyle(
                          color: AppColors.accentYellow,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.textPrimary.withOpacity(0.3),
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
