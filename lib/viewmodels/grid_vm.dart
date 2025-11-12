import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/dot_model.dart';
import '../data/local/local_storage_service.dart';

class GridVM extends GetxController {
  final RxList<DotModel> dots = <DotModel>[].obs;
  final LocalStorageService _storage = LocalStorageService();

  /// Global blink speed (applies to all dots)
  final RxString blinkSpeed = 'Medium'.obs;

  @override
  void onInit() {
    super.onInit();
    loadGrid(); // ✅ Load saved grid (if exists)
    loadSpeed(); // ✅ Load saved blink speed
  }

  /// Generate a new grid (default: 9x8)
  void generateGrid({int rows = 9, int cols = 8}) {
    dots.clear();
    int total = rows * cols;
    for (int i = 0; i < total; i++) {
      dots.add(DotModel(id: i));
    }
    saveGrid();
  }

  /// Toggle dot selection state
  void toggleSelect(int id) {
    final index = dots.indexWhere((d) => d.id == id);
    if (index != -1) {
      dots[index].toggleSelect();
      dots.refresh();
      saveGrid(); // ✅ Auto-save
    }
  }

  /// Apply color to all selected dots
  void applyColor(Color color) {
    for (var dot in dots.where((d) => d.selected)) {
      dot.applyColor(color);
    }
    dots.refresh();
    saveGrid(); // ✅ Auto-save
  }

  /// Apply brightness to all selected dots
  void applyBrightness(double brightness) {
    for (var dot in dots.where((d) => d.selected)) {
      dot.brightness = brightness;
    }
    dots.refresh();
    saveGrid(); // ✅ Auto-save
  }

  /// Apply blink speed (global, not per-dot)
  void applySpeed(String speed) {
    blinkSpeed.value = speed;
    saveSpeed(speed); // ✅ Save globally
  }

  /// Reset all dots to default
  void resetGrid() {
    for (var d in dots) {
      d.reset();
    }
    dots.refresh();
    saveGrid(); // ✅ Save reset state
  }

  /// Change visibility (used during blinking)
  void toggleVisibility(int id, bool isVisible) {
    final index = dots.indexWhere((d) => d.id == id);
    if (index != -1) {
      dots[index].visible = isVisible;
      dots.refresh();
    }
  }

  /// Save grid state to GetStorage
  void saveGrid() {
    _storage.saveGrid(dots.map((d) => d.toMap()).toList());
  }

  /// Load grid state from GetStorage
  void loadGrid() {
    final saved = _storage.getGrid();
    if (saved != null && saved.isNotEmpty) {
      dots.assignAll(saved.map((e) => DotModel.fromMap(e)).toList());
    } else {
      generateGrid(); // ✅ If no saved data, create new
    }
  }

  /// Save blink speed separately
  void saveSpeed(String speed) {
    _storage.saveBlinkSpeed(speed);
  }

  /// Load blink speed from GetStorage
  void loadSpeed() {
    final savedSpeed = _storage.getBlinkSpeed();
    if (savedSpeed != null) {
      blinkSpeed.value = savedSpeed;
    }
  }
}
