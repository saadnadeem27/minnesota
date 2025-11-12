import 'package:flutter/material.dart';

class DotModel {
  final int id;
  bool selected;
  Color color;
  bool visible; // ✅ for blinking animation
  double brightness; // ✅ optional brightness control (0.0–1.0)

  DotModel({
    required this.id,
    this.selected = false,
    this.color = Colors.blue,
    this.visible = true,
    this.brightness = 1.0,
  });

  /// ✅ Toggle the dot’s selection state
  void toggleSelect() => selected = !selected;

  /// ✅ Change dot color
  void applyColor(Color newColor) {
    color = newColor;
  }

  /// ✅ Reset to default
  void reset() {
    selected = false;
    color = Colors.blue;
    visible = true;
    brightness = 1.0;
  }

  /// ✅ Convert to Map for GetStorage
  Map<String, dynamic> toMap() => {
    'id': id,
    'selected': selected,
    'color': color.value,
    'visible': visible,
    'brightness': brightness,
  };

  /// ✅ Create from Map (when loading from GetStorage)
  factory DotModel.fromMap(Map<String, dynamic> map) {
    return DotModel(
      id: map['id'] ?? 0,
      selected: map['selected'] ?? false,
      color: Color(map['color'] ?? Colors.blue.value),
      visible: map['visible'] ?? true,
      brightness: (map['brightness'] ?? 1.0).toDouble(),
    );
  }

  /// ✅ Copy method (for immutability if needed)
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
