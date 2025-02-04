import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../fragment/home_screen.dart';
import '../fragment/favorite_screen.dart';
import '../fragment/profile_screen.dart';
import 'auth_services.dart';
import 'theme_services.dart';

class DashboardService extends GetxService{
  final AuthServices authServices = Get.find<AuthServices>();

  var selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  Widget get currentScreen => screens[selectedIndex.value];

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<DashboardService> init() async {
    return this;
  }


}