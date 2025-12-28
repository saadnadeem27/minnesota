import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/local/local_storage_service.dart';
import 'grid_vm.dart';
import 'settings_vm.dart';

class SessionVM extends GetxController {
  final RxBool isRunning = false.obs;
  Timer? _timer;

  final LocalStorageService _storage = LocalStorageService();

  final GridVM gridVM = Get.find<GridVM>();
  final SettingsVM settingsVM = Get.find<SettingsVM>();

  int tick = 0;

  void startSession() {
    if (isRunning.isTrue) return;

    isRunning.value = true;

    // Determine blink speed
    String speed = settingsVM.blinkSpeed.value;
    if (speed.isEmpty) speed = gridVM.blinkSpeed.value;


    int interval = _getInterval(speed);

    // 🌟 HIDE ALL SELECTED DOTS IMMEDIATELY
    for (var d in gridVM.dots.where((e) => e.selected)) {
      gridVM.toggleVisibility(d.id, false);
    }

    final random = Random();

    _timer = Timer.periodic(Duration(milliseconds: interval), (_) {
      if (!isRunning.value) return;

      final selectedDots = gridVM.dots.where((d) => d.selected).toList();
      if (selectedDots.isEmpty) return;

      // random dot
      final randomDot = selectedDots[random.nextInt(selectedDots.length)];

      // SHOW blink
      gridVM.toggleVisibility(randomDot.id, true);

      // hide after delay
      Future.delayed(const Duration(milliseconds: 140), () {
        if (!isRunning.value) return;
        gridVM.toggleVisibility(randomDot.id, false);
      });
    });
  }


  void stopSession() {
    if (!isRunning.value) return;

    isRunning.value = false;
    _timer?.cancel();
    _timer = null;

    // Reset all dots
    for (var d in gridVM.dots) {
      gridVM.replaceDot(d.id, visible: true);
    }
  }

  int _getInterval(String speed) {
    switch (speed) {
      case 'Fast': return 750; // Fast
      case 'Medium': return 1000; // Medium
      default: return 1250; // Slow
    }
  }
}
