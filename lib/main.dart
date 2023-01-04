import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'app/my_app.dart';
import 'core/common_export.dart';

void main() async {
  //WidgetFlutterBinding используется для взаимодействия с движком Flutter, иначе асинхронные функции стартующие
  //до запуска runApp подвиснут
  WidgetsFlutterBinding.ensureInitialized();

  //инициализация наших цветовых схем
  await themeHandler.init();

  //инициализация языковых настроек
  await languageHandler.init();

  //Hive - NoSQL Database
  await Hive.initFlutter();

  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: ChangeNotifierProvider<LanguageModel>(
        create: (context) => LanguageModel(),
        child: MyApp(),
      ),
    ),
  );
}
