import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/constants/app_constants.dart';

// ─────────────────────────────────────────────────────────────────────────────
// THEME CONTROLLER
// Manages dark/light mode with SharedPreferences persistence
// ─────────────────────────────────────────────────────────────────────────────

class ThemeController extends GetxController {
  final RxBool isDark = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getBool(AppConstants.themeKey);
      isDark.value = saved ?? true; // Default to dark
      _applyTheme();
    } catch (e) {
      if (kDebugMode) print('ThemeController: Failed to load theme — $e');
    }
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    _applyTheme();
    _saveTheme();
  }

  void setDark() {
    isDark.value = true;
    _applyTheme();
    _saveTheme();
  }

  void setLight() {
    isDark.value = false;
    _applyTheme();
    _saveTheme();
  }

  void _applyTheme() {
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.themeKey, isDark.value);
    } catch (e) {
      if (kDebugMode) print('ThemeController: Failed to save theme — $e');
    }
  }
}
