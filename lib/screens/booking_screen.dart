import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/booking_controller.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate or find the BookingController
    final BookingController controller = Get.put(BookingController());

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  
                  // 1. Header (Night stay count and Cancel Button)
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.stayTitle,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.cancelDates,
                          child: const Text(
                            "Cancel Date",
                            style: TextStyle(
                              color: AppColors.accentOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  // 2. Date subtitle range
                  Obx(
                    () => Text(
                      controller.subtitle,
                      style: TextStyle(
                        color: AppColors.textPrimary.withOpacity(0.6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // 3. Calendar Container
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppColors.borderLight,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Month / Year Label
                        Obx(
                          () => Text(
                            controller.monthYear.value,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Calendar Dates Grid
                        Obx(
                          () {
                            // Read observables synchronously so Obx registers them.
                            // GridView.builder calls itemBuilder lazily.
                            final _ = controller.startDate.value;
                            final __ = controller.endDate.value;
                            
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.days.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                final day = controller.days[index];
                                final isSelected = controller.isDaySelected(day);
                                final isInRange = controller.isDayInRange(day);
                                
                                return GestureDetector(
                                  onTap: () => controller.onDayTap(day),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? AppColors.primary
                                          : isInRange
                                              ? AppColors.primary.withOpacity(0.15)
                                              : Colors.transparent,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${day.day}",
                                      style: TextStyle(
                                        color: day.isCurrentMonth
                                            ? (isSelected ? Colors.white : AppColors.textPrimary.withOpacity(0.8))
                                            : AppColors.textPrimary.withOpacity(0.2),
                                        fontSize: 15,
                                        fontWeight: isSelected || isInRange
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),
                  
                  // 4. Navigation arrows
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavArrow(Icons.arrow_back_ios_new_rounded, controller.previousMonth),
                      const SizedBox(width: 32),
                      _buildNavArrow(Icons.arrow_forward_ios_rounded, controller.nextMonth),
                    ],
                  ),
                  const SizedBox(height: 100), // Extra padding at bottom for nav bar
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
