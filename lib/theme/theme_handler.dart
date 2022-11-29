import 'package:affairs/core/common_export.dart';
import 'package:affairs/theme/common/theme.dart';
import 'package:affairs/theme/dark/dark_theme.dart';
import 'package:affairs/theme/light/light_theme.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Appearance { light, dark, system }

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

final ThemeProvider themeProvider = ThemeProvider();

ITheme get theme => ThemeProvider().theme;

class ThemeProvider extends ChangeNotifier {
  static final ThemeProvider t = ThemeProvider._internal();
  static const _appearanceKey = "appearance";
  late SharedPreferences _preferences;

  Appearance _appearance = Appearance.system;

  Appearance get appearance => _appearance;
  ITheme theme = LightTheme();

  factory ThemeProvider() {
    return t;
  }

  ThemeProvider._internal();

  void updateTheme(Appearance appearance) {
    _appearance = appearance;
    _saveAppearance();
    theme = resolveTheme(appearance);
    rebuildTypography();
    _updateAppIcon();
    notifyListeners();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _appearance = _getSavedAppearance();
    theme = resolveTheme(_appearance);
    rebuildTypography();
    // _updateAppIcon();
  }

  void _updateAppIcon() {
    const platform = MethodChannel('appIconChannel');
    platform.invokeMethod('changeIcon', isDarkMode() ? "Dark" : "Light");
  }

  Appearance _getSavedAppearance() {
    return appearanceFromName(_preferences.getString(_appearanceKey) ?? "") ?? Appearance.system;
  }

  void _saveAppearance() {
    _preferences.setString(_appearanceKey, _appearance.name);
  }

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

  ITheme _resolveSystemTheme() {
    return _isSystemDarkAppearance() ? DarkTheme() : LightTheme();
  }

  bool _isSystemDarkAppearance() {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  bool isDarkMode() {
    return appearance == Appearance.dark || (appearance == Appearance.system && _isSystemDarkAppearance());
  }
}
