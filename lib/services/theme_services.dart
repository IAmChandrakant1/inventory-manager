import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  final picker = ImagePicker();
  File? file;
  XFile? pickedFile;

  static ThemeService get to => Get.find();
  Rx<ThemeMode> theme = ThemeMode.light.obs;

  ThemeMode get currentTheme => theme.value;
  RxBool notificationToggle = true.obs;

  static const String _themeKey = 'app_theme';

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey) ?? 0;
    theme.value = themeIndex == 0 ? ThemeMode.light : ThemeMode.dark;
    Get.changeThemeMode(theme.value);
  }

  Future<void> saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode == ThemeMode.light ? 0 : 1);
  }

  Future<void> switchTheme(ThemeMode mode) async {
    theme.value = mode;
    await saveTheme(mode);
    Get.changeThemeMode(mode);
  }

  Future<ThemeService> init() async {
    await loadTheme();
    return this;
  }
}
