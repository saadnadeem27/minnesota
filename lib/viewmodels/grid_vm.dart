import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/dot_model.dart';
import '../data/local/local_storage_service.dart';

class GridVM extends GetxController {
  final RxList<DotModel> dots = <DotModel>[].obs;
  final LocalStorageService _storage = LocalStorageService();

  /// Global blink speed (Slow / Medium / Fast)
  final RxString blinkSpeed = 'Medium'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadGridSafe();
    _loadSpeedSafe();
  }

  // =============================================================
  // GRID MANAGEMENT
  // =============================================================

  /// Generate fresh 9x8 grid
  void generateGrid({int rows = 9, int cols = 8}) {
    dots.clear();
    int total = rows * cols;

    for (int i = 0; i < total; i++) {
      dots.add(DotModel(id: i));
    }
    saveGrid();
  }

  /// Select / unselect a dot
  void toggleSelect(int id) {
    final index = dots.indexWhere((d) => d.id == id);
    if (index == -1) return;

    dots[index] = dots[index].copyWith(
      selected: !dots[index].selected,
    );
    dots.refresh();
    saveGrid();
  }

  /// Apply color to selected dots ONLY
  void applyColor(Color color) {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].selected) {
        dots[i] = dots[i].copyWith(color: color);
      }
    }
    dots.refresh();
    saveGrid();
  }

  /// Apply brightness to selected dots ONLY
  void applyBrightness(double value) {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].selected) {
        dots[i] = dots[i].copyWith(brightness: value);
      }
    }
    dots.refresh();
    saveGrid();
  }

  /// Apply global blink speed
  void applySpeed(String speed) {
    blinkSpeed.value = speed;
    saveSpeed(speed);
  }

  /// Reset entire grid
  void resetGrid() {
    for (int i = 0; i < dots.length; i++) {
      dots[i] = dots[i].copyWith(
        selected: false,
        color: const Color(0xFF2196F3), // UI safe default
        visible: true,
        brightness: 1.0,
      );
    }
    dots.refresh();
    saveGrid();
  }

  /// Visibility toggle (used by blinking)
  void toggleVisibility(int id, bool isVisible) {
    final index = dots.indexWhere((d) => d.id == id);
    if (index == -1) return;

    dots[index] = dots[index].copyWith(visible: isVisible);

    /// 🔥 REQUIRED for UI to update on each blink
    dots.refresh();
  }

  // =============================================================
  // STORAGE
  // =============================================================

  void saveGrid() {
    try {
      _storage.saveGrid(dots.map((d) => d.toMap()).toList());
    } catch (e) {
      debugPrint("❌ Error saving grid: $e");
    }
  }

  void _loadGridSafe() {
    try {
      final saved = _storage.getGrid();
      if (saved != null && saved.isNotEmpty) {
        dots.assignAll(saved.map((e) => DotModel.fromMap(e)).toList());
      } else {
        generateGrid();
      }
    } catch (e) {
      debugPrint("❌ Grid load failed, regenerating: $e");
      generateGrid();
    }
  }

  void saveSpeed(String speed) {
    _storage.saveBlinkSpeed(speed);
  }


  /// Replace dot safely — allows blinking to update UI instantly
  void replaceDot(int id, {bool? visible}) {
    final index = dots.indexWhere((d) => d.id == id);
    if (index == -1) return;

    dots[index] = dots[index].copyWith(
      visible: visible ?? dots[index].visible,
    );
  }



  void _loadSpeedSafe() {
    try {
      final stored = _storage.getBlinkSpeed();

      // 🔥 Debug print for confirmation
      debugPrint("[GridVM] Loading saved blink speed: $stored");

      if (stored != null && stored.trim().isNotEmpty) {
        // Only allow valid speeds
        if (stored == 'Fast' || stored == 'Medium' || stored == 'Slow') {
          blinkSpeed.value = stored;
        } else {
          debugPrint("[GridVM] Invalid stored speed \"$stored\" → resetting to Medium");
          blinkSpeed.value = 'Medium';
          saveSpeed('Medium');
        }
      } else {
        // No saved speed → default to Medium
        blinkSpeed.value = 'Medium';
        saveSpeed('Medium');
      }

      debugPrint("[GridVM] ACTIVE blink speed: ${blinkSpeed.value}");

    } catch (e) {
      debugPrint("[GridVM] Error loading blink speed → using Medium. Error: $e");
      blinkSpeed.value = 'Medium';
      saveSpeed('Medium');
    }
  }
}

