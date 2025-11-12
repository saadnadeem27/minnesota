import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/local/local_storage_service.dart';
import 'grid_vm.dart';
import 'settings_vm.dart';

class SessionVM extends GetxController {
  final RxBool isRunning = false.obs;
  Timer? _timer;
  final _storage = LocalStorageService();

  // Access other controllers
  final GridVM gridVM = Get.find<GridVM>();
  final SettingsVM settingsVM = Get.find<SettingsVM>();

  /// 🟢 Start the blinking session
  void startSession() {
    if (isRunning.value) return;

    isRunning.value = true;

    // ✅ Determine blinking interval (based on stored or selected speed)
    String currentSpeed =
    settingsVM.blinkSpeed.value.isNotEmpty ? settingsVM.blinkSpeed.value : gridVM.blinkSpeed.value;

    int interval;
    switch (currentSpeed) {
      case 'Fast':
        interval = 250;
        break;
      case 'Medium':
        interval = 500;
        break;
      default:
        interval = 800;
    }

    // ✅ Save session info for stats / resume
    _storage.saveSession({
      'startedAt': DateTime.now().toIso8601String(),
      'speed': currentSpeed,
      'brightness': settingsVM.brightness.value,
      'totalDots': gridVM.dots.where((d) => d.selected).length,
    });

    // ✅ Start blinking timer
    final random = Random();
    _timer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (!isRunning.value) {
        timer.cancel();
        return;
      }

      final selectedDots = gridVM.dots.where((d) => d.selected).toList();
      if (selectedDots.isEmpty) return;

      // Pick a random dot
      final randomDot = selectedDots[random.nextInt(selectedDots.length)];

      // 🔁 Blink effect: toggle visibility briefly
      randomDot.visible = false;
      gridVM.dots.refresh();

      // Restore visibility after a short delay
      Future.delayed(const Duration(milliseconds: 150), () {
        if (isRunning.value) {
          randomDot.visible = true;
          gridVM.dots.refresh();
        }
      });
    });
  }

  /// 🔴 Stop blinking and restore all dots
  void stopSession() {
    if (!isRunning.value) return;
    isRunning.value = false;

    _timer?.cancel();
    _timer = null;

    for (var dot in gridVM.dots) {
      dot.visible = true;
    }

    gridVM.dots.refresh();

    // ✅ Log session end
    _storage.saveSession({
      'endedAt': DateTime.now().toIso8601String(),
      'completed': true,
    });
  }

  /// 🎨 Change color of blinking dots (applies globally)
  void changeBlinkColor(Color color) {
    for (var dot in gridVM.dots.where((d) => d.selected)) {
      dot.color = color;
    }
    gridVM.dots.refresh();
    gridVM.saveGrid(); // ✅ persist color
  }

  /// 🧹 Reset everything safely
  void resetSession() {
    stopSession();
    gridVM.resetGrid();
    settingsVM.resetSettings();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
