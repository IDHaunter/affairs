import 'dart:io';

import 'package:affairs/core/common_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { russian, english }

Language? languageFromName(String name) {
  switch (name) {
    case "english":
      return Language.english;
    case "russian":
      return Language.russian;
    default:
      return null;
  }
}

final LanguageProvider languageProvider = LanguageProvider();

class LanguageProvider extends ChangeNotifier {
  static final t = LanguageProvider._internal();
  static const _languageKey = "language";
  static const _manuallyChangedKey = "manuallyChanged";
  late SharedPreferences _preferences;

  bool _manuallyChanged = false;
  Language _language = Language.russian;

  Language get language => _language;

  factory LanguageProvider() {
    return t;
  }

  LanguageProvider._internal();

  bool get manuallyChanged => _manuallyChanged;

  void updateLanguage(Language language, {required bool manually}) {
    _language = language;
    _saveLanguage();
    _preferences.setBool(_manuallyChangedKey, manually);
    notifyListeners();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _manuallyChanged = _isManuallyChanged();
    _language = _resolveLanguage();
  }

  Language _getSavedLanguage() {
    return languageFromName(_preferences.getString(_languageKey) ?? "") ?? Language.russian;
  }

  void _saveLanguage() {
    _preferences.setString(_languageKey, _language.name);
  }

  bool _isManuallyChanged() {
    return _preferences.getBool(_manuallyChangedKey) ?? false;
  }

  Language _resolveLanguage() {
    if (_manuallyChanged) {
      return _getSavedLanguage();
    } else {
      return _resolveSystemLanguage();
    }
  }

  Language _resolveSystemLanguage() {
    final locale = Platform.localeName;
    if (locale.toLowerCase().contains("ru")) {
      return Language.russian;
    } else {
      return Language.english;
    }
  }

  Locale getLocale() {
    switch (_language) {
      case Language.russian:
        return const Locale.fromSubtags(languageCode: "ru");
      case Language.english:
        return const Locale.fromSubtags(languageCode: "en");
    }
  }
}
