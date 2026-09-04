import 'package:get/get.dart';

class CalendarDay {
  final int day;
  final bool isCurrentMonth;

  CalendarDay({required this.day, required this.isCurrentMonth});
}

class BookingController extends GetxController {
  final RxnInt startDate = RxnInt(24); // Default Feb 24
  final RxnInt endDate = RxnInt(26);   // Default Feb 26
  final RxString monthYear = "Feb 2026".obs;

  // Grid dates matching February 2026 grid layout
  final List<CalendarDay> days = [
    // Row 1
    CalendarDay(day: 1, isCurrentMonth: true),
    CalendarDay(day: 2, isCurrentMonth: true),
    CalendarDay(day: 3, isCurrentMonth: true),
    CalendarDay(day: 4, isCurrentMonth: true),
    CalendarDay(day: 5, isCurrentMonth: true),
    CalendarDay(day: 6, isCurrentMonth: true),
    CalendarDay(day: 7, isCurrentMonth: true),
    // Row 2
    CalendarDay(day: 8, isCurrentMonth: true),
    CalendarDay(day: 9, isCurrentMonth: true),
    CalendarDay(day: 10, isCurrentMonth: true),
    CalendarDay(day: 11, isCurrentMonth: true),
    CalendarDay(day: 12, isCurrentMonth: true),
    CalendarDay(day: 13, isCurrentMonth: true),
    CalendarDay(day: 14, isCurrentMonth: true),
    // Row 3
    CalendarDay(day: 15, isCurrentMonth: true),
    CalendarDay(day: 16, isCurrentMonth: true),
    CalendarDay(day: 17, isCurrentMonth: true),
    CalendarDay(day: 18, isCurrentMonth: true),
    CalendarDay(day: 19, isCurrentMonth: true),
    CalendarDay(day: 20, isCurrentMonth: true),
    CalendarDay(day: 21, isCurrentMonth: true),
    // Row 4
    CalendarDay(day: 22, isCurrentMonth: true),
    CalendarDay(day: 23, isCurrentMonth: true),
    CalendarDay(day: 24, isCurrentMonth: true),
    CalendarDay(day: 25, isCurrentMonth: true),
    CalendarDay(day: 26, isCurrentMonth: true),
    CalendarDay(day: 27, isCurrentMonth: true),
    CalendarDay(day: 28, isCurrentMonth: true),
    // Row 5
    CalendarDay(day: 29, isCurrentMonth: false),
    CalendarDay(day: 30, isCurrentMonth: false),
    CalendarDay(day: 31, isCurrentMonth: false),
    CalendarDay(day: 1, isCurrentMonth: false),
    CalendarDay(day: 2, isCurrentMonth: false),
    CalendarDay(day: 3, isCurrentMonth: false),
    CalendarDay(day: 4, isCurrentMonth: false),
  ];

  void onDayTap(CalendarDay day) {
    if (!day.isCurrentMonth) return;

    if (startDate.value == null || (startDate.value != null && endDate.value != null)) {
      startDate.value = day.day;
      endDate.value = null;
    } else if (startDate.value != null && endDate.value == null) {
      if (day.day < startDate.value!) {
        startDate.value = day.day;
      } else if (day.day == startDate.value) {
        startDate.value = null;
      } else {
        endDate.value = day.day;
      }
    }
  }

  void cancelDates() {
    startDate.value = null;
    endDate.value = null;
  }

  void nextMonth() {
    if (monthYear.value == "Feb 2026") {
      monthYear.value = "Mar 2026";
    } else if (monthYear.value == "Jan 2026") {
      monthYear.value = "Feb 2026";
    }
  }

  void previousMonth() {
    if (monthYear.value == "Feb 2026") {
      monthYear.value = "Jan 2026";
    } else if (monthYear.value == "Mar 2026") {
      monthYear.value = "Feb 2026";
    }
  }

  String get stayTitle {
    if (startDate.value == null) return "Select Dates";
    if (endDate.value == null) return "1-night stay";
    final diff = endDate.value! - startDate.value!;
    return "$diff-night stay";
  }

  String get subtitle {
    if (startDate.value == null) return "Pick your travel check-in date";
    
    final startStr = _formatDate(startDate.value!);
    if (endDate.value == null) return startStr;
    
    final endStr = _formatDate(endDate.value!);
    return "$startStr – $endStr";
  }

  String _formatDate(int day) {
    final weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final weekdayIndex = (day - 1) % 7;
    final weekday = weekdays[weekdayIndex];
    return "$weekday, Feb $day";
  }

  bool isDaySelected(CalendarDay day) {
    if (!day.isCurrentMonth) return false;
    return day.day == startDate.value || day.day == endDate.value;
  }

  bool isDayInRange(CalendarDay day) {
    if (!day.isCurrentMonth || startDate.value == null || endDate.value == null) return false;
    return day.day > startDate.value! && day.day < endDate.value!;
  }
}
