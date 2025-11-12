class SettingsModel {
  double brightness;
  String speed;

  SettingsModel({
    this.brightness = 0.8,
    this.speed = 'Medium',
  });

  Map<String, dynamic> toMap() => {
    'brightness': brightness,
    'speed': speed,
  };

  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
    brightness: map['brightness'] ?? 0.8,
    speed: map['speed'] ?? 'Medium',
  );
}
