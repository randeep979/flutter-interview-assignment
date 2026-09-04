import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onCardTap;

  const DashboardScreen({
    super.key,
    required this.onMenuPressed,
    required this.onCardTap,
  });

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
        body: 

        
        SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // 1. Header (Greeting and Double-Bar Menu Button)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning\nPrabhat",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    GestureDetector(
                      onTap: onMenuPressed,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.buttonBackground.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 18,
                                height: 2,
                                color: AppColors.textPrimary,
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: 18,
                                height: 2,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Search Location Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: TextField(
                          style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Search Location",
                            hintStyle: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.mic_none_rounded,
                        color: AppColors.textPrimary.withOpacity(0.7),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 3. Scrollable Travel Cards Feed
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                  children: [
                    _buildResortCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
                      title: "Toronto, Canada",
                      distance: "150KM",
                      dates: "OCT 24–25",
                      price: "\$50.00",
                      onTap: onCardTap,
                      heroTag: 'resort_hero',
                    ),
                    const SizedBox(height: 20),
                    _buildResortCard(
                      context: context,
                      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
                      title: "Vancouver, Canada",
                      distance: "820KM",
                      dates: "OCT 27–29",
                      price: "\$75.00",
                      onTap: () {},
                      heroTag: 'vancouver_hero',
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

  Widget _buildResortCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String distance,
    required String dates,
    required String price,
    required VoidCallback onTap,
    required String heroTag,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              // Main Image
              Positioned.fill(
                child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.surface,
                        child: const Center(
                          child: Icon(Icons.image, color: AppColors.textPrimary, size: 40),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Floating Overlay Card details at bottom
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.overlayContainer.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailColumn("Distance", distance),
                          _buildDetailColumn("Available", dates),
                          _buildDetailColumn("Price", price),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
