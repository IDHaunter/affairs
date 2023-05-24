import 'dart:io';
import 'package:affairs/core/common_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

//https://docs.flutter.dev/accessibility-and-localization/internationalization
//настройки автогенерации находятся в файле l10n.yaml (правим если нужно)
//шаблоны перевода в файлах app_en.arb и app_ru.arb (добавляем/правим новые слова если нужно)
//вызов автогенератора: flutter gen-l10n - в результате пропатчится файл app_localizations.dart который прописан в l10n.yaml

//Список языков
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

//Создание экземпляра обработчика
final LanguageHandler languageHandler = LanguageHandler();

//обработчик
class LanguageHandler  { //extends ChangeNotifier
  //Должен существовать в единственном экземпляре, поэтому конструируется через
  //спец конструктор _internal() и затем экземпляр просто возвращается через factory
  static final t = LanguageHandler._internal();
  //ключ для хранения настройки
  static const _languageKey = "language";
  //ключ для хранения признака ручной установки
  //static const _manuallyChangedKey = "manuallyChanged";
  late SharedPreferences _preferences;

  bool _manuallyChanged = false;
  Language _language = Language.russian;

  Language get language => _language;

  //Фабрика обеспечивающая единый экземпляр носителя
  factory LanguageHandler() {
    return t;
  }

  LanguageHandler._internal();

  bool get manuallyChanged => _manuallyChanged;

  void updateLanguage(Language language, {required bool manually}) {
    _language = language;
    _saveLanguage();
    //_preferences.setBool(_manuallyChangedKey, manually);
    //notifyListeners();
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

  //Проверка на ручную установку языка
  bool _isManuallyChanged() {
    //return _preferences.getBool(_manuallyChangedKey) ?? false;
    return _preferences.containsKey(_languageKey);
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
