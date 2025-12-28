import 'package:flutter/material.dart';

class DotModel {
  final int id;
  bool selected;
  Color color;
  bool visible;           // Used for blinking animation
  double brightness;      // Range: 0.0 – 1.0

  DotModel({
    required this.id,
    this.selected = false,
    this.color = Colors.blue,
    this.visible = true,
    this.brightness = 1.0,
  });

  /// Toggle selected state
  void toggleSelect() => selected = !selected;

  /// Apply new color
  void applyColor(Color newColor) {
    color = newColor;
  }

  /// Apply brightness safely
  void applyBrightness(double value) {
    brightness = value.clamp(0.1, 1.0);
  }

  /// Reset to clean default state
  void reset() {
    selected = false;
    color = Colors.blue;
    visible = true;
    brightness = 1.0;
  }

  /// Convert object → Map (for GetStorage)
  Map<String, dynamic> toMap() => {
    'id': id,
    'selected': selected,
    'color': color.value,
    'visible': visible,
    'brightness': brightness,
  };

  /// Create object ← Map (from GetStorage)
  factory DotModel.fromMap(Map<String, dynamic> map) {
    return DotModel(
      id: map['id'],
      selected: map['selected'] ?? false,
      color: Color(map['color'] ?? Colors.blue.value),
      visible: map['visible'] ?? true,
      brightness: (map['brightness'] ?? 1.0).toDouble(),
    );
  }

  /// Copy method (supports animations / updates)
  DotModel copyWith({
    int? id,
    bool? selected,
    Color? color,
    bool? visible,
    double? brightness,
  }) {
    return DotModel(
      id: id ?? this.id,
      selected: selected ?? this.selected,
      color: color ?? this.color,
      visible: visible ?? this.visible,
      brightness: brightness ?? this.brightness,
    );
  }
}
