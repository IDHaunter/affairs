import 'package:affairs/core/common_export.dart';
import 'package:affairs/theme/common/theme.dart';
import 'package:affairs/theme/dark/dark_theme.dart';
import 'package:affairs/theme/light/light_theme.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Список тем
enum Appearance { light, dark, system }

//процедура нужна для конвертации сохранённого текстового ключа в тему из списка
Appearance? appearanceFromName(String name) {
  switch (name) {
    case "light":
      return Appearance.light;
    case "dark":
      return Appearance.dark;
    case "system":
      return Appearance.system;
    default:
      return null;
  }
}

//Создание экземпляра Носителя всех настроек цветовой схемы
final ThemeHandler themeHandler = ThemeHandler();
//Геттер упрощающий написание кода, чтобы не писать везде ThemeHandler().currentITheme
ITheme get curITheme => ThemeHandler().currentITheme;
//Носитель цветовых настроек
class ThemeHandler { //extends ChangeNotifier - поскольку за обновление отвечает ThemeModel то она и будет оповещать
  //Должен существовать в единственном экземпляре, поэтому конструируется через
  //спец конструктор _internal() и затем экземпляр просто возвращается через factory
  static final ThemeHandler t = ThemeHandler._internal();
  //ключ для хранения настройки
  static const _appearanceKey = "appearance";
  late SharedPreferences _preferences;

  //по умолчанию пусть тема будет типа системная
  Appearance _appearance = Appearance.system;
  //и типо это будет светлая тема (но )
  ITheme currentITheme = LightTheme();

  Appearance get appearance => _appearance;

  //собственно фабрика для гарантирования инициализации одного экземпляра t
  // static final ThemeHandler t = ThemeHandler._internal()
  factory ThemeHandler() {
    return t;
  }
  //Собственно именованый конструктор который и нужен для создания t
  ThemeHandler._internal();

  //Функция которая обновляет тему и может уведомлять подписчиков
  void updateTheme(Appearance appearance) {
    _appearance = appearance;
    //Сохраняет новые данные
    _saveAppearance();
    //в зависимости от типа appearance устанавливает LightTheme() или DarkTheme()
    currentITheme = resolveTheme(appearance);
    //обновляет цветовые настройки шрифтов
    rebuildTypography();
    //Обновляет признак иконки
    _updateAppIcon();
    //Собственно уведомляем подписаных
    //notifyListeners();
  }

  //Набор действий при старте приложения
  Future<void> init() async{
    //загрузка предыдущих настроек
    _preferences = await SharedPreferences.getInstance();
    _appearance = _getSavedAppearance();
    //в зависимости от типа appearance устанавливает LightTheme() или DarkTheme()
    currentITheme = resolveTheme(_appearance);
    //обновляем цветовые настройки шрифтов
    rebuildTypography();
    //_updateAppIcon();
  }

  void _updateAppIcon() {
    const platform = MethodChannel('appIconChannel');
    platform.invokeMethod('changeIcon', isDarkMode() ? "Dark" : "Light");
  }

  //Получаем сохранённую цветовую схему
  Appearance _getSavedAppearance() {
    return appearanceFromName(_preferences.getString(_appearanceKey) ?? "") ?? Appearance.system;
    return Appearance.system;
  }

  //Сохраняем текущую цветовую схему
  void _saveAppearance() {
    _preferences.setString(_appearanceKey, _appearance.name);
  }

  //в зависимости от типа возвращает LightTheme() или DarkTheme()
  ITheme resolveTheme(Appearance appearance) {
    switch (appearance) {
      case Appearance.light:
        return LightTheme();
      case Appearance.dark:
        return DarkTheme();
      case Appearance.system:
        return _resolveSystemTheme();
    }
  }

  //Если тема системная то вычисляем тёмная она или светлая по системным настройкам
  ITheme _resolveSystemTheme() {
    return _isSystemDarkAppearance() ? DarkTheme() : LightTheme();
  }

  //Получение текущей цветовой схемы из системных настроек, true - тёмная
  bool _isSystemDarkAppearance() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  //true - тёмная
  bool isDarkMode() {
    return appearance == Appearance.dark || (appearance == Appearance.system && _isSystemDarkAppearance());
  }
}

String nameFromAppearance(Appearance appearance) {
  switch (appearance) {
    case Appearance.light:
      return "Now it's Light";
    case Appearance.dark:
      return "Now it's Dark";
    default:
      return "Now it's System";
  }
}
////////////////////////////////////////////////////////////////////////////////
//Конструируем модель типа ThemeData для провайдера  исходя из данных носителя
//чтобы её использовать в ChangeNotifierProvider который
//и будет обновлять состояние приложения
class ThemeModel extends ChangeNotifier {
  //Основная переменная которая и хранит текущую схему
  //при инициализации берёт настройку из носителя themeHandler
  ThemeData currentTheme = ThemeData(
    primaryColor: curITheme.primary(),
    colorScheme: themeHandler.isDarkMode()
        ? const ColorScheme.dark()
        : const ColorScheme.light(),
    // colorScheme: brightness == Brightness.dark ? const ColorScheme.dark() :  const ColorScheme.light(),
  );

  String sDrawer = nameFromAppearance(themeHandler.appearance);

  //Добавляет в стандартную тёмную или светлую системную схему наши цвета из носителя
  addColors() {
    currentTheme = currentTheme.copyWith(
      colorScheme: currentTheme.colorScheme.copyWith(
          secondary: curITheme.accent(),
          primary: curITheme.primary()), //Colors.pinkAccent Colors.pink

    );
  }

  //Обновление текущей темы
  changeCurrentTheme(Appearance appearance) {
    currentTheme = ThemeData(
      primaryColor: curITheme.primary(),
      colorScheme: themeHandler.isDarkMode()
          ? const ColorScheme.dark()
          : const ColorScheme.light(),
    );
    addColors();
    sDrawer = nameFromAppearance(themeHandler.appearance);
    //Собственно уведомляем подписаных
    notifyListeners();
    }

}