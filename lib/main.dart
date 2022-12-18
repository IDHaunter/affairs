import 'app/pages/home_page.dart';
import 'app/pages/theme_page.dart';
import 'core/common_export.dart';

void main() {
  //инициализация наших цветовых схем
  themeHandler.init();

  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = languageProvider.getLocale();

  @override
  void initState() {
    super.initState();
    languageProvider.addListener(() {
      setState(() {
        _locale = languageProvider.getLocale();
      });
    });
    _locale = languageProvider.getLocale();
    Provider.of<ThemeModel>(context, listen: false).addColors();
  }

  @override
  Widget build(BuildContext context) {

    //Provider это обёртка для InheritedWidget
    //flutter_bloc и MobX используют provider в своей реализации

    return ChangeNotifierProvider<DataGlobal>(
      create: (context) => DataGlobal(),
      //Если бы использовали Provider то работали через метод create: (context)=>data,
      //create: (context)=>'The end of the Fucking world',
      // где data - любая переменная с данными которая автоматом была бы доступна ТОЛЬКО по дереву вниз
      //
      child: MaterialApp(
        //отключаем баннер Debug в верхнем правом углу
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeModel>(context, listen: true ).currentTheme,
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
        locale: _locale,
        //home: HomePage(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/theme_page': (context) => ThemePage(),
        },
      ),
    );
  }
}
