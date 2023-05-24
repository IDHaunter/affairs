import '../common_export.dart';

//-------------------------------------------------------------------------------------------------------
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

  //Добавляет в стандартную тёмную или светлую системную схему наши цвета из носителя
  addColors() {
    currentTheme = currentTheme.copyWith(
      colorScheme: currentTheme.colorScheme.copyWith(
          secondary: curITheme.accent(),
          primary: curITheme.primary()), //Colors.pinkAccent Colors.pink
      //примешивать цвета текста можно как отдельно по видам headline1, headline2 ...
      //textTheme: TextTheme(headline1: TextStyle(color: curITheme.textPrimary()),
      //                     subtitle1: TextStyle(color: curITheme.textPrimary())),
      //так и по группам видов bodyColor и displayColor
      textTheme: currentTheme.textTheme.apply(bodyColor: curITheme.textPrimary(),
          displayColor: curITheme.textPrimary()),
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
    //Собственно уведомляем подписаных
    notifyListeners();
  }

}