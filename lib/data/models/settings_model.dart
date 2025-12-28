import 'package:flutter/material.dart';

class SettingsModel {
  double brightness;
  String speed;
  int color;            // 🔵 color stored as int
  bool fadeAnimation;   // ✨ new fade mode

  SettingsModel({
    this.brightness = 0.8,
    this.speed = 'Medium',
    this.color = 0xFF0000FF, // Default: Blue
    this.fadeAnimation = true,
  });

  /// Convert to Map for GetStorage
  Map<String, dynamic> toMap() => {
    'brightness': brightness,
    'speed': speed,
    'color': color,
    'fadeAnimation': fadeAnimation,
  };

  /// Load from storage safely
  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
    brightness: (map['brightness'] ?? 0.8).toDouble(),
    speed: map['speed'] ?? 'Medium',
    color: map['color'] ?? 0xFF0000FF,
    fadeAnimation: map['fadeAnimation'] ?? true,
  );
}
