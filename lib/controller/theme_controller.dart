import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_services.dart';

class ThemeController extends GetxController {
  static ThemeService get to => Get.find();

  ThemeMode get currentTheme => to.currentTheme;
  Rx<ThemeMode> get theme => to.theme;

  switchTheme(ThemeMode mode) {
    to.switchTheme(mode);
    update();
  }

}