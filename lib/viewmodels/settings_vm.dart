import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/local/local_storage_service.dart';
import 'grid_vm.dart';

class SettingsVM extends GetxController {
  /// Default safe color (NOT MaterialColor)
  final Rx<Color> selectedColor = const Color(0xFF2196F3).obs;

  final RxDouble brightness = 0.8.obs;
  final RxString blinkSpeed = 'Medium'.obs;
  final RxBool fadeAnimation = true.obs;

  final LocalStorageService _storage = LocalStorageService();
  late GridVM gridVM;

  @override
  void onInit() {
    super.onInit();

    /// SAFE: check GridVM exists (avoids app start crash)
    if (Get.isRegistered<GridVM>()) {
      gridVM = Get.find<GridVM>();
    } else {
      gridVM = Get.put(GridVM()); // fallback
    }

    loadSettings();
  }

  // ===========================================================
  // UPDATE METHODS
  // ===========================================================

  void updateColor(Color color) {
    selectedColor.value = color;

    // Apply only to already selected dots
    gridVM.applyColor(color);

    saveSettings();
  }

  void updateBrightness(double value) {
    final safeValue = value.clamp(0.1, 1.0);
    brightness.value = safeValue;

    // Apply brightness only to selected dots
    gridVM.applyBrightness(safeValue);

    saveSettings();
  }

  void updateBlinkSpeed(String newSpeed) {
    blinkSpeed.value = newSpeed;
    gridVM.applySpeed(newSpeed);   // this sends speed to grid
    saveSettings();
  }


  void toggleFade() {
    fadeAnimation.value = !fadeAnimation.value;
    saveSettings();
  }

  // ===========================================================
  // SAVE / LOAD SETTINGS
  // ===========================================================

  void saveSettings() {
    _storage.saveSettings({
      'color': selectedColor.value.value,
      'brightness': brightness.value,
      'blinkSpeed': blinkSpeed.value,
      'fadeAnimation': fadeAnimation.value,
    });
  }

  void loadSettings() {
    final saved = _storage.getSettings();

    if (saved != null) {
      if (saved['color'] != null) {
        selectedColor.value = Color(saved['color']);
      }

      brightness.value = (saved['brightness'] ?? 0.8).toDouble();
      blinkSpeed.value = saved['blinkSpeed'] ?? 'Medium';
      fadeAnimation.value = saved['fadeAnimation'] ?? true;

      // NO auto-color apply → keeps your selected dots correct
      gridVM.applyBrightness(brightness.value);
      gridVM.applySpeed(blinkSpeed.value);
    } else {
      saveSettings();
    }
  }

  // ===========================================================
  // RESET SETTINGS
  // ===========================================================

  void resetSettings() {
    selectedColor.value = const Color(0xFF2196F3);
    brightness.value = 0.8;
    blinkSpeed.value = 'Medium';
    fadeAnimation.value = true;

    gridVM.applyBrightness(0.8);
    gridVM.applySpeed('Medium');

    saveSettings();
  }
}
