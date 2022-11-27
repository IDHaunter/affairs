import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'models/data_global.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    //Получаем настройки цветовой схемы
    final Brightness? brightness;
    WidgetsBinding.instance.addObserver(widget);
    brightness = WidgetsBinding.instance.window.platformBrightness;
    //Удалям прослушку настроек цветовой схемы т.к. менять её по ходу работы приложения не планируем
    WidgetsBinding.instance.removeObserver(widget);
    //В соответствии с цветовой схемой подключаем тему при этом добавляя немного цветовых акцентов
    ThemeData theme = ThemeData(
        primaryColor: Colors.pink,
        colorScheme: brightness == Brightness.dark ? const ColorScheme.dark() :  const ColorScheme.light(),
      //ColorScheme.fromSwatch()
    );

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
        home: HomePage(),
      ),
    );
  }
}
