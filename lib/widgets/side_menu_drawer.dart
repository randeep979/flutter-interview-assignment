import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/navigation_controller.dart';

class SideMenuDrawer extends StatefulWidget {
  const SideMenuDrawer({super.key});

  @override
  State<SideMenuDrawer> createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  String _activeMenuItem = "Payment"; // Default active menu item matching Image 4
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    const profileUrl = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150';
    final NavigationController navCtrl = Get.find<NavigationController>();
    
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (Avatar, Name, Location, Close button)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF334155),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        profileUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, color: AppColors.textPrimary);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Alice Premium",
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Toronto, Canada",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: navCtrl.closeDrawer,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              
              // 2. Scrollable Settings List
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildSectionHeader("Account Setting"),
                    _buildMenuItem(
                      title: "Notification",
                      icon: Icons.notifications_none_rounded,
                      badgeCount: 12,
                      navCtrl: navCtrl,
                    ),
                    _buildMenuItem(
                      title: "Payment",
                      icon: Icons.notifications_none_rounded, // Matches the mockup's duplicate icons
                      navCtrl: navCtrl,
                    ),
                    _buildMenuItem(
                      title: "Translate",
                      icon: Icons.notifications_none_rounded,
                      navCtrl: navCtrl,
                    ),
                    _buildMenuItem(
                      title: "Privacy",
                      icon: Icons.notifications_none_rounded,
                      navCtrl: navCtrl,
                    ),
                    
                    const SizedBox(height: 20),
                    _buildSectionHeader("Account Setting"),
                    _buildMenuItem(
                      title: "Listing",
                      icon: Icons.notifications_none_rounded,
                      navCtrl: navCtrl,
                    ),
                    _buildMenuItem(
                      title: "Host",
                      icon: Icons.notifications_none_rounded,
                      navCtrl: navCtrl,
                    ),
                    
                    const SizedBox(height: 20),
                    _buildSectionHeader("Account Setting"),
                    _buildDarkModeTile(),
                    _buildMenuItem(
                      title: "Update",
                      icon: Icons.notifications_none_rounded,
                      navCtrl: navCtrl,
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    int? badgeCount,
    required NavigationController navCtrl,
  }) {
    final isActive = _activeMenuItem == title;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeMenuItem = title;
          });
          
          if (title == "Dashboard") {
            navCtrl.selectTab(0);
          } else if (title == "Listing" || title == "Host") {
            navCtrl.selectTab(1);
          } else {
            Get.snackbar(
              "Navigation",
              "Opened $title",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primary,
              colorText: Colors.white,
              duration: const Duration(seconds: 1),
            );
          }
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.white : AppColors.surface.withOpacity(0.4),
                ),
                child: Icon(
                  icon,
                  color: isActive ? AppColors.primary : AppColors.textPrimary.withOpacity(0.6),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textPrimary.withOpacity(0.8),
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (badgeCount != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "$badgeCount",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (badgeCount == null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isActive ? Colors.white : AppColors.textPrimary.withOpacity(0.3),
                  size: 12,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDarkModeTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withOpacity(0.4),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary.withOpacity(0.6),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "Dark Mode",
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.8),
                  fontSize: 15,
                ),
              ),
            ),
            Switch(
              value: _isDarkMode,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.surface,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: AppColors.surface.withOpacity(0.5),
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ],
        ),
      ),
    );
  }
}
