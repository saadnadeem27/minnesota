import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LocalStorageService {
  final _box = GetStorage();

  // 🔹 KEYS — centralized for easy management
  static const String _dotsKey = 'dots';
  static const String _settingsKey = 'settings';
  static const String _sessionsKey = 'sessions';
  static const String _blinkSpeedKey = 'blinkSpeed';

  // =======================================================
  // 🟢 GRID STORAGE
  // =======================================================

  /// Save grid dots (each as a map)
  void saveGrid(List<Map<String, dynamic>> dots) {
    try {
      _box.write(_dotsKey, dots);
    } catch (e) {
      debugPrint('❌ Error saving grid: $e');
    }
  }

  /// Load grid data (returns list or null)
  List<Map<String, dynamic>>? getGrid() {
    try {
      final data = _box.read<List>(_dotsKey);
      return data?.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('❌ Error reading grid: $e');
      return null;
    }
  }

  // =======================================================
  // ⚙️ SETTINGS STORAGE
  // =======================================================

  /// Save user settings (color, brightness, speed, fade)
  void saveSettings(Map<String, dynamic> settings) {
    try {
      _box.write(_settingsKey, settings);
    } catch (e) {
      debugPrint('❌ Error saving settings: $e');
    }
  }

  /// Retrieve settings from local storage
  Map<String, dynamic>? getSettings() {
    try {
      final data = _box.read<Map<String, dynamic>>(_settingsKey);
      return data;
    } catch (e) {
      debugPrint('❌ Error reading settings: $e');
      return null;
    }
  }

  // =======================================================
  // ⚡ BLINK SPEED STORAGE (global, independent from settings)
  // =======================================================

  void saveBlinkSpeed(String speed) {
    try {
      _box.write(_blinkSpeedKey, speed);
    } catch (e) {
      debugPrint('❌ Error saving blink speed: $e');
    }
  }

  String? getBlinkSpeed() {
    try {
      return _box.read<String>(_blinkSpeedKey);
    } catch (e) {
      debugPrint('❌ Error reading blink speed: $e');
      return null;
    }
  }

  // =======================================================
  // 🧠 SESSION HISTORY STORAGE
  // =======================================================

  /// Save a session log (includes start time, speed, etc.)
  void saveSession(Map<String, dynamic> session) {
    try {
      final sessions = _box.read<List>(_sessionsKey) ?? [];
      sessions.add(session);
      _box.write(_sessionsKey, sessions);
    } catch (e) {
      debugPrint('❌ Error saving session: $e');
    }
  }

  /// Retrieve all past session logs
  List<Map<String, dynamic>> getSessions() {
    try {
      final sessions = _box.read<List>(_sessionsKey) ?? [];
      return sessions.cast<Map<String, dynamic>>();
    } catch (e) {
      debugPrint('❌ Error reading sessions: $e');
      return [];
    }
  }

  // =======================================================
  // 🧹 CLEAR DATA
  // =======================================================

  /// Clear all saved data (grid, settings, sessions)
  Future<void> clearAll() async {
    try {
      await _box.erase();
      debugPrint('✅ Local storage cleared successfully.');
    } catch (e) {
      debugPrint('❌ Error clearing storage: $e');
    }
  }
}
