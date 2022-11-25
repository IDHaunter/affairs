import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Получаем настройки цветовой схемы
    final Brightness? brightness;
    WidgetsBinding.instance.addObserver(this);
    brightness = WidgetsBinding.instance.window.platformBrightness;
    //Удалям прослушку настроек цветовой схемы т.к. менять её по ходу работы приложения не планируем
    WidgetsBinding.instance.removeObserver(this);
    //В соответствии с цветовой схемой подключаем тему при этом добавляя немного цветовых акцентов
    ThemeData theme = ThemeData(
        primaryColor: Colors.red,
        colorScheme: brightness == Brightness.dark ? const ColorScheme.dark() :  const ColorScheme.light(),
      //ColorScheme.fromSwatch()
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false, //отключает баннер Debug в верхнем правом углу
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.redAccent, ),
      ),
      title: 'Менеджер дел',
      home: HomePage(),
    );
  }
}
