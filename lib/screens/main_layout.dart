import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/side_menu_drawer.dart';
import 'dashboard_screen.dart';
import 'hotels_resort_screen.dart';
import 'booking_screen.dart';
import 'account_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with SingleTickerProviderStateMixin {
  late final NavigationController _navCtrl;
  late AnimationController _drawerAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _drawerSlideAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize NavigationController in GetX dependency manager
    _navCtrl = Get.put(NavigationController());

    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.84).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 250.0).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _borderRadiusAnimation = Tween<double>(begin: 0.0, end: 32.0).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _drawerSlideAnimation = Tween<double>(begin: -40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Listen to GetX reactive state changes to control the drawer animation
    ever(_navCtrl.isDrawerOpen, (isOpen) {
      if (isOpen) {
        _drawerAnimationController.forward();
      } else {
        _drawerAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    super.dispose();
  }

  Widget _buildCurrentScreen(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return DashboardScreen(
          onMenuPressed: _navCtrl.toggleDrawer,
          onCardTap: () => _navCtrl.selectTab(1),
        );
      case 1:
        return const HotelsResortScreen();
      case 2:
        return const BookingScreen();
      case 3:
        return const AccountScreen();
      default:
        return DashboardScreen(
          onMenuPressed: _navCtrl.toggleDrawer,
          onCardTap: () => _navCtrl.selectTab(1),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 1. Drawer Menu Layer
            AnimatedBuilder(
              animation: _drawerAnimationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_drawerSlideAnimation.value, 0),
                  child: Opacity(
                    opacity: _drawerAnimationController.value,
                    child: child,
                  ),
                );
              },
              child: const SideMenuDrawer(),
            ),

            // 2. Main Content View Layer
            AnimatedBuilder(
              animation: _drawerAnimationController,
              builder: (context, child) {
                final slide = _slideAnimation.value;
                final scale = _scaleAnimation.value;
                final radius = _borderRadiusAnimation.value;

                return Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4 * _drawerAnimationController.value),
                          blurRadius: 30,
                          spreadRadius: 2,
                          offset: const Offset(-10, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: child,
                    ),
                  ),
                );
              },
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    // Active screen tab (rendered reactively using Obx)
                    Obx(
                      () => Positioned.fill(
                        child: _buildCurrentScreen(_navCtrl.selectedTab.value),
                      ),
                    ),

                  // Floating Bottom Navigation Bar
                  const Positioned(
                    left: 20,
                    right: 20,
                    bottom: 24,
                    child: CustomBottomNavBar(),
                  ),

                  // Overlay Tap detector when drawer is open
                  Obx(
                    () => _navCtrl.isDrawerOpen.value
                        ? Positioned.fill(
                            child: GestureDetector(
                              onTap: _navCtrl.closeDrawer,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                color: Colors.black.withOpacity(0.01),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
