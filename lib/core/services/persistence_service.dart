import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  final SharedPreferences _prefs;

  PersistenceService(this._prefs);

  static const String _keyThemeMode = 'theme_mode';
  static const String _keyVisitedIds = 'visited_ids';
  static const String _keyFavoriteIds = 'favorite_ids';

  static final ValueNotifier<Set<String>> favoritesNotifier = ValueNotifier<Set<String>>({});

  static Future<PersistenceService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final service = PersistenceService(prefs);
    favoritesNotifier.value = service.getFavoriteIds();
    return service;
  }

  // ── Theme Mode ─────────────────────────────────────────────────────────────

  ThemeMode getThemeMode() {
    final modeString = _prefs.getString(_keyThemeMode);
    if (modeString == null) return ThemeMode.system;
    
    switch (modeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    String modeString;
    switch (mode) {
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }
    await _prefs.setString(_keyThemeMode, modeString);
  }

  // ── Visited Widgets (Progress) ─────────────────────────────────────────────

  Set<String> getVisitedIds() {
    final list = _prefs.getStringList(_keyVisitedIds);
    return list?.toSet() ?? <String>{};
  }

  Future<void> saveVisitedIds(Set<String> ids) async {
    await _prefs.setStringList(_keyVisitedIds, ids.toList());
  }

  // ── Favorite Widgets ───────────────────────────────────────────────────────

  Set<String> getFavoriteIds() {
    final list = _prefs.getStringList(_keyFavoriteIds);
    return list?.toSet() ?? <String>{};
  }

  Future<void> saveFavoriteIds(Set<String> ids) async {
    await _prefs.setStringList(_keyFavoriteIds, ids.toList());
  }

  Future<void> toggleFavorite(String id) async {
    final current = Set<String>.from(favoritesNotifier.value);
    if (current.contains(id)) {
      current.remove(id);
    } else {
      current.add(id);
    }
    favoritesNotifier.value = current;
    await saveFavoriteIds(current);
  }

  // ── Clear All ──────────────────────────────────────────────────────────────

  Future<void> clearAll() async {
    await _prefs.remove(_keyThemeMode);
    await _prefs.remove(_keyVisitedIds);
    await _prefs.remove(_keyFavoriteIds);
    favoritesNotifier.value = {};
  }
}
