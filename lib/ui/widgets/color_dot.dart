import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../viewmodels/settings_vm.dart' show SettingsVM;

class ColorDot extends StatelessWidget {
  final Color color;
  final bool visible;
  final double brightness;
  final double size;

  const ColorDot({
    super.key,
    required this.color,
    this.visible = true,
    this.brightness = 1.0,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsVM settingsVM = Get.find<SettingsVM>();
    final bool fadeEnabled = settingsVM.fadeAnimation.value;

    // 🔥 If visible → show colored dot
    // 🔥 If NOT visible → show grey dot (NOT disappear)
    final Color displayColor = visible
        ? color.withOpacity(brightness)
        : Colors.grey[300]!;

    return AnimatedContainer(
      duration: Duration(milliseconds: fadeEnabled ? 150 : 0),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: displayColor,
        boxShadow: visible
            ? [
          BoxShadow(
            color: displayColor.withOpacity(0.4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ]
            : [],
      ),
    );
  }
}
