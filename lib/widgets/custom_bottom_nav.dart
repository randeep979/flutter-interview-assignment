import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/navigation_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navCtrl = Get.find<NavigationController>();

    return Obx(
      () => Container(
        height: 72,
        decoration: BoxDecoration(
          color: AppColors.navBackground.withOpacity(0.95),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: AppColors.borderNav,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              index: 0,
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: "Dashboard",
              navCtrl: navCtrl,
            ),
            _buildNavItem(
              index: 1,
              icon: Icons.flight_outlined,
              activeIcon: Icons.flight_rounded,
              label: "Hotels Resort",
              navCtrl: navCtrl,
            ),
            _buildNavItem(
              index: 2,
              icon: Icons.calendar_today_outlined,
              activeIcon: Icons.calendar_today_rounded,
              label: "Booking Hotel",
              navCtrl: navCtrl,
            ),
            _buildProfileNavItem(
              index: 3,
              label: "Account",
              navCtrl: navCtrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required NavigationController navCtrl,
  }) {
    final isActive = navCtrl.selectedTab.value == index;

    return GestureDetector(
      onTap: () => navCtrl.selectTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 54,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.buttonBackground,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
              size: 24,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileNavItem({
    required int index,
    required String label,
    required NavigationController navCtrl,
  }) {
    final isActive = navCtrl.selectedTab.value == index;
    const profileUrl = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150';

    return GestureDetector(
      onTap: () => navCtrl.selectTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: isActive ? 12 : 8),
        height: 54,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.buttonBackground,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF334155),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: Image.network(
                  profileUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.person,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
