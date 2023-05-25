import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'app/my_app.dart';
import 'core/auth/auth_model.dart';
import 'core/common_export.dart';
import 'core/data/hive/hive_service.dart';
import 'core/service_locator.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized() используется для взаимодействия с движком Flutter, иначе асинхронные
  //функции стартующие до запуска runApp подвиснут
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //удерживаем сплеш экран до момента полной инициализации
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //инициализация языковых настроек
  await languageHandler.init();

  //инициализация наших цветовых схем
  await themeHandler.init();

  //инициализация GetIt и его содержимого
  setupGetIt();
  await getIt.allReady();
  await getIt<HiveService>().init();

  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: ChangeNotifierProvider<LanguageModel>(
        create: (context) => LanguageModel(),
        child: ChangeNotifierProvider<AuthModel>(
          create: (context) => AuthModel(),
          child: const MyApp(),
        ),
      ),
    ),
  );
}
