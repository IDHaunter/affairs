import 'app/pages/home_page.dart';
import 'app/pages/theme_page.dart';
import 'app/pages/language_page.dart';
import 'app/pages/group/group_page.dart';
import 'core/common_export.dart';

void main() async {
  //WidgetFlutterBinding используется для взаимодействия с движком Flutter, иначе асинхронные функции стартующие
  //до запуска runApp подвиснут
  WidgetsFlutterBinding.ensureInitialized();

  //инициализация наших цветовых схем
  await themeHandler.init();

  //инициализация языковых настроек
  await languageHandler.init();

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

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Locale _locale = languageHandler.getLocale();

  @override
  void initState() {
    super.initState();
   // _locale = languageHandler.getLocale();
    Provider.of<ThemeModel>(context, listen: false).addColors();
  }

  @override
  Widget build(BuildContext context) {
    //Provider это обёртка для InheritedWidget
    //flutter_bloc и MobX используют provider в своей реализации

    return ChangeNotifierProvider<DataGlobal>(
      create: (context) => DataGlobal(),
      //Если бы использовали Provider то работали через метод create: (context)=>data,
      //или даже просто create: (context)=>'The end of the Fucking world',
      //где data - любая переменная (класс) с любыми данными которые автоматом были бы доступны ТОЛЬКО по дереву вниз
      child: MaterialApp(
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
        initialRoute: '/',
        routes: {
          //тут нельзя задавать const т.к. при смене тем оформления будет глюк
          '/': (context) => HomePage(),
          '/theme_page': (context) => ThemePage(),
          '/language_page': (context) => LanguagePage(),
          '/group_page': (context) => GroupPage(),
        },
      ),
    );
  }
}
