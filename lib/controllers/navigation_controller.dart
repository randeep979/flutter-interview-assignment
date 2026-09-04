import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt selectedTab = 0.obs;
  final RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }

  void selectTab(int index) {
    selectedTab.value = index;
    closeDrawer();
  }
}
