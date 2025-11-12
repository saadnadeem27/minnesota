import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/local/local_storage_service.dart';
import 'grid_vm.dart';

class SettingsVM extends GetxController {
  final Rx<Color> selectedColor = Colors.blue.obs;
  final RxDouble brightness = 0.8.obs;
  final RxString blinkSpeed = 'Medium'.obs;
  final RxBool fadeAnimation = true.obs;

  final LocalStorageService _storage = LocalStorageService();
  late GridVM gridVM;

  @override
  void onInit() {
    super.onInit();
    // ✅ Safely find GridVM (if available)
    gridVM = Get.find<GridVM>();
    loadSettings(); // ✅ Load user preferences at startup
  }

  // ✅ Update color (and sync with grid)
  void updateColor(Color color) {
    selectedColor.value = color;
    gridVM.applyColor(color);
    saveSettings();
  }

  // ✅ Update brightness (and sync with grid)
  void updateBrightness(double value) {
    final safeValue = value.clamp(0.1, 1.0);
    brightness.value = safeValue;
    gridVM.applyBrightness(safeValue);
    saveSettings();
  }

  // ✅ Update blink speed (sync globally)
  void updateBlinkSpeed(String newSpeed) {
    blinkSpeed.value = newSpeed;
    gridVM.applySpeed(newSpeed);
    saveSettings();
  }

  // ✅ Toggle fade animation
  void toggleFade() {
    fadeAnimation.value = !fadeAnimation.value;
    saveSettings();
  }

  // ✅ Save all settings locally
  void saveSettings() {
    _storage.saveSettings({
      'color': selectedColor.value.value,
      'brightness': brightness.value,
      'blinkSpeed': blinkSpeed.value,
      'fadeAnimation': fadeAnimation.value,
    });
  }

  // ✅ Load settings from local storage
  void loadSettings() {
    final saved = _storage.getSettings();
    if (saved != null) {
      if (saved['color'] != null) {
        selectedColor.value = Color(saved['color']);
      }
      brightness.value = (saved['brightness'] ?? 0.8).toDouble();
      blinkSpeed.value = saved['blinkSpeed'] ?? 'Medium';
      fadeAnimation.value = saved['fadeAnimation'] ?? true;

      // ✅ Apply to grid after loading
      gridVM.applyColor(selectedColor.value);
      gridVM.applyBrightness(brightness.value);
      gridVM.applySpeed(blinkSpeed.value);
    } else {
      saveSettings(); // Ensure default settings persist
    }
  }

  // ✅ Reset all settings to default
  void resetSettings() {
    selectedColor.value = Colors.blue;
    brightness.value = 0.8;
    blinkSpeed.value = 'Medium';
    fadeAnimation.value = true;
    gridVM.applyColor(Colors.blue);
    gridVM.applyBrightness(0.8);
    gridVM.applySpeed('Medium');
    saveSettings();
  }
}
