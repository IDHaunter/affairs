import 'package:shared_preferences/shared_preferences.dart';

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

class AuthService {
  //ключ для хранения настройки
  static const _authKey = "auth";
  final SharedPreferences _preferences;

  AuthService(this._preferences) {
    _setup();
  }

  AuthEnum _currentAuth = AuthEnum.noAuth;

  AuthEnum get currentAuth => _currentAuth;

  //Обновление текущего способа авторизации
  changeCurrentAuth(AuthEnum authEnum) {
    _currentAuth = authEnum;
    _saveAuth();
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
    _currentAuth = _getSavedAuth();
  }

}