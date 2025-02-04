import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../fragment/home_screen.dart';
import '../fragment/favorite_screen.dart';
import '../fragment/profile_screen.dart';
import '../services/auth_services.dart';
import '../services/dashboard_services.dart';

class DashboardController extends GetxController {
  final DashboardService dashboardService = Get.find<DashboardService>();
  final AuthServices authServices = Get.find<AuthServices>();

  @override
  void onInit() {
    super.onInit();
  }

  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  Widget get currentScreen => screens[selectedIndex.value];

  void updateSelectedIndex(int index) {
    print('updateSelectedIndex: $index');
    dashboardService.changeSelectedIndex(index);
    update();
  }

}