import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodels/settings_vm.dart';

class ColorDot extends StatelessWidget {
  final Color color;
  final bool visible;
  final double brightness;

  const ColorDot({
    super.key,
    required this.color,
    this.visible = true,
    this.brightness = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsVM settingsVM = Get.find<SettingsVM>();
    final bool fadeEnabled = settingsVM.fadeAnimation.value;

    final Color adjustedColor = color.withOpacity(visible ? brightness : 0.0);

    return AnimatedContainer(
      duration: Duration(milliseconds: fadeEnabled ? 300 : 0),
      curve: Curves.easeInOut,
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: adjustedColor,
        shape: BoxShape.circle,
        boxShadow: visible
            ? [
          BoxShadow(
            color: adjustedColor.withOpacity(0.5),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ]
            : [],
      ),
    );
  }
}
