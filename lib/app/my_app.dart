import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../core/common_export.dart';

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
static final mainNavigator = MainNavigator();

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeModel>(context, listen: false).addColors();
    //после инициализации всех ресурсов убираем сплеш-экран
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //Provider это обёртка для InheritedWidget
    //flutter_bloc и MobX используют provider в своей реализации

    return MaterialApp(
        //отключаем баннер Debug в верхнем правом углу
        debugShowCheckedModeBanner: false,
        //тему приложения будем обновлять через провайдер
        theme: Provider.of<ThemeModel>(context, listen: true).currentTheme,
        title: 'Менеджер дел',
        localizationsDelegates: const [
          AppLocalizations.delegate, // Языковые настройки
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('ru', ''), // Russian, no country code
        ],
        locale: Provider.of<LanguageModel>(context, listen: true).currentLocale,
        //home: HomePage(),
        initialRoute: mainNavigator.initialRoute,
        routes: mainNavigator.routes,
        onGenerateRoute: mainNavigator.onGenerateRoute,
      );

  }
}