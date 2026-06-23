import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterlearn/core/services/persistence_service.dart';

void main() {
  group('PersistenceService Tests', () {
    late SharedPreferences prefs;
    late PersistenceService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      service = PersistenceService(prefs);
    });

    test('getThemeMode defaults to system', () {
      expect(service.getThemeMode(), ThemeMode.system);
    });

    test('saveThemeMode and getThemeMode light', () async {
      await service.saveThemeMode(ThemeMode.light);
      expect(service.getThemeMode(), ThemeMode.light);
    });

    test('saveThemeMode and getThemeMode dark', () async {
      await service.saveThemeMode(ThemeMode.dark);
      expect(service.getThemeMode(), ThemeMode.dark);
    });

    test('getVisitedIds defaults to empty set', () {
      expect(service.getVisitedIds(), isEmpty);
    });

    test('saveVisitedIds and getVisitedIds', () async {
      final ids = {'futurebuilder-demo', 'streambuilder-demo'};
      await service.saveVisitedIds(ids);
      expect(service.getVisitedIds(), equals(ids));
    });

    test('getFavoriteIds defaults to empty set', () {
      expect(service.getFavoriteIds(), isEmpty);
    });

    test('saveFavoriteIds and getFavoriteIds', () async {
      final ids = {'http-get-demo', 'mediaquery-demo'};
      await service.saveFavoriteIds(ids);
      expect(service.getFavoriteIds(), equals(ids));
    });

    test('clearAll clears preferences', () async {
      await service.saveThemeMode(ThemeMode.dark);
      await service.saveVisitedIds({'visited-1'});
      await service.saveFavoriteIds({'fav-1'});

      await service.clearAll();

      expect(service.getThemeMode(), ThemeMode.system);
      expect(service.getVisitedIds(), isEmpty);
      expect(service.getFavoriteIds(), isEmpty);
    });
  });
}
