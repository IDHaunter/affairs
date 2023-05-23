//Список видов авторизации
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/common_export.dart';

enum AuthEnum { noAuth, localAuth }

AuthEnum? authEnumFromName(String name) {
  switch (name) {
    case "noAuth":
      return AuthEnum.noAuth;
    case "localAuth":
      return AuthEnum.localAuth;
    default:
      return null;
  }
}

class AuthSettingsViewModel extends ChangeNotifier {
  //ключ для хранения настройки
  static const _authKey = "auth";
  late SharedPreferences _preferences;
  AuthEnum _currentAuth = AuthEnum.noAuth;

  AuthEnum get currentAuth => _currentAuth;

  AuthSettingsViewModel() {
    _setup();
  }

  //Обновление текущего способа авторизации
  changeCurrentAuth(AuthEnum authEnum) {
    _currentAuth = authEnum;
    //Собственно уведомляем подписаных
    notifyListeners();
  }

  //Получаем сохранённый способ авторизации
  AuthEnum _getSavedAuth() {
    return authEnumFromName(_preferences.getString(_authKey) ?? "") ?? AuthEnum.noAuth;
  }

  //Сохраняем текущую способ авторизации
  void _saveAuth() {
    _preferences.setString(_authKey, _currentAuth.name);
  }

  //Инициализация (не асинхронная!)
  void _setup() async{
    //загрузка предыдущих настроек
    _preferences = await SharedPreferences.getInstance();
    _currentAuth = _getSavedAuth();
  }

}