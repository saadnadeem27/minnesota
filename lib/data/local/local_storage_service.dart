import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LocalStorageService {
  final GetStorage _box = GetStorage();

  // 🔑 Centralized Keys
  static const String dotsKey = 'dots';
  static const String settingsKey = 'settings';
  static const String sessionsKey = 'sessions';
  static const String blinkSpeedKey = 'blinkSpeed';

  // =======================================================
  // 🟦 GRID STORAGE
  // =======================================================

  /// Save grid (list of dot maps)
  void saveGrid(List<Map<String, dynamic>> dots) {
    try {
      _box.write(dotsKey, dots);
    } catch (e) {
      debugPrint('❌ saveGrid error: $e');
    }
  }

  /// Load grid safely
  List<Map<String, dynamic>>? getGrid() {
    try {
      final list = _box.read<List>(dotsKey);
      return list?.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      debugPrint('❌ getGrid error: $e');
      return null;
    }
  }

  // =======================================================
  // ⚙️ SETTINGS STORAGE
  // =======================================================

  /// Save all settings (brightness, speed, color, fade)
  void saveSettings(Map<String, dynamic> settings) {
    try {
      _box.write(settingsKey, settings);
    } catch (e) {
      debugPrint('❌ saveSettings error: $e');
    }
  }

  /// Load settings map safely
  Map<String, dynamic>? getSettings() {
    try {
      final raw = _box.read(settingsKey);
      if (raw == null) return null;
      return Map<String, dynamic>.from(raw);
    } catch (e) {
      debugPrint('❌ getSettings error: $e');
      return null;
    }
  }

  // =======================================================
  // ⚡ BLINK SPEED STORAGE (Independent global key)
  // =======================================================

  void saveBlinkSpeed(String speed) {
    try {
      _box.write(blinkSpeedKey, speed);
    } catch (e) {
      debugPrint('❌ saveBlinkSpeed error: $e');
    }
  }

  String? getBlinkSpeed() {
    try {
      return _box.read<String>(blinkSpeedKey);
    } catch (e) {
      debugPrint('❌ getBlinkSpeed error: $e');
      return null;
    }
  }

  // =======================================================
  // 🧠 SESSION HISTORY STORAGE
  // =======================================================

  /// Save a new session record
  void saveSession(Map<String, dynamic> session) {
    try {
      final existing = _box.read<List>(sessionsKey) ?? [];
      existing.add(session);
      _box.write(sessionsKey, existing);
    } catch (e) {
      debugPrint('❌ saveSession error: $e');
    }
  }

  /// Load all session records
  List<Map<String, dynamic>> getSessions() {
    try {
      final list = _box.read<List>(sessionsKey) ?? [];
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      debugPrint('❌ getSessions error: $e');
      return [];
    }
  }

  // =======================================================
  // 🧹 CLEAR EVERYTHING
  // =======================================================

  Future<void> clearAll() async {
    try {
      await _box.erase();
      debugPrint('✅ All local storage cleared.');
    } catch (e) {
      debugPrint('❌ clearAll error: $e');
    }
  }
}
