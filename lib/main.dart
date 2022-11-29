import 'app/pages/home_page.dart';
import 'core/common_export.dart';

void main() {
  runApp(MyApp());
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
  }

  @override
  Widget build(BuildContext context) {

    //Получаем настройки цветовой схемы
    final Brightness? brightness;
    //WidgetsBinding.instance.addObserver(widget);
    brightness = WidgetsBinding.instance.window.platformBrightness;
    //Удалям прослушку настроек цветовой схемы т.к. менять её по ходу работы приложения не планируем
    //WidgetsBinding.instance.removeObserver(widget);
    //В соответствии с цветовой схемой подключаем тему при этом добавляя немного цветовых акцентов
    ThemeData theme = ThemeData(
        primaryColor: Colors.pink,
        colorScheme: brightness == Brightness.dark ? const ColorScheme.dark() :  const ColorScheme.light(),
      //ColorScheme.fromSwatch()
    );


/*  import 'package:flutter/services.dart';
*  SystemChrome.setSystemUIOverlayStyle(themeProvider.isDarkMode() ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
*
* */


    //Provider это обёртка для InheritedWidget
    //flutter_bloc и MobX используют provider в своей реализации

    return ChangeNotifierProvider<DataGlobal>(
      create: (context) =>  DataGlobal(),
      //Если бы использовали Provider то работали через метод create: (context)=>data,
      //create: (context)=>'The end of the Fucking world',
      // где data - любая переменная с данными которая автоматом была бы доступна ТОЛЬКО по дереву вниз
      //
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //отключает баннер Debug в верхнем правом углу
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.pinkAccent, ),
        ),
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
        home: HomePage(),
      ),
    );
  }
}
