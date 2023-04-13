import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
//В отличие от provider или inherit для getIt не нужен context и его единый контейнер с данными может быть доступен
//из любой части программы при условии что была произведена его однократная инициализация
//минусом getIt является необходимость делать действия по инициализации контейнера, инициализации (setup) всего
// его содержимого и действия при init и dispose для прослушивателей addListener
// особым плюсом также является описание всех зависимостей внутри одного контейнера, т.е. лаконичный код

//наш глобальный ServiceLocator
//по сути это глобальная переменная-контейнер для хранения данных
GetIt getIt = GetIt.instance;

//Абстракция модели данных
abstract class AppModel extends ChangeNotifier {
  void incrementCounter();
  int get counter;
}

//Реализация модели
class AppModelImplementation extends AppModel {
  int _counter = 0;

  AppModelImplementation() {
    /// Имитируем асинхронную инициализацию
    Future.delayed(const Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  int get counter => _counter;

  @override
  void incrementCounter() {
    _counter++;
    //несмотря на то, что сам GetIt не используется обычно для stateManagment, мы добавим эту функцию
    notifyListeners();
  }
}

// Простейшая синхронная модель данных например для хранения глобальных переменных
class TextPageModel {
  final String sTitleApp= 'Flutter Demo';
  final String sTitlePage= 'Flutter Demo Home Page';
  String sText= 'You have never pushed the blue button in the corner...';
  final String sWait= 'Waiting for initialisation';
}

//Процедура инициализации всех зависимостей
void setupGetIt() {
  getIt.registerSingleton<AppModel>(AppModelImplementation(),
      signalsReady: true);

  getIt.registerSingleton<TextPageModel>(TextPageModel());

}

void main() {
  //Инициализация делается сразу в main до запуска визуальной части
  setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: getIt<TextPageModel>().sTitleApp,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: getIt<TextPageModel>().sTitlePage),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // Доступ к сущности AppModel для прослушивания изменений её состояния и вызова функции update
    // Поскольку AppModel асинхронна нам нужно убедится в её готовности используя getAsync
    getIt
        .isReady<AppModel>()
        .then((_) => getIt<AppModel>().addListener(update));
    // Альтернатива
    // getIt.getAsync<AppModel>().addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    //При уничтожении стейта мы удаляем слушателя изменений
    getIt<AppModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {
    if (getIt<AppModel>().counter==1)
      {getIt<TextPageModel>().sText="Congrats! You've pushed the fucking button for the first time"}
    else {getIt<TextPageModel>().sText='You have pushed the fucking button ${getIt<AppModel>().counter} times!'}
  });


  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: getIt.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Text( getIt<TextPageModel>().sText,
                      ),
                      Text(
                        getIt<AppModel>().counter.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: getIt<AppModel>().incrementCounter,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(getIt<TextPageModel>().sWait),
                  const SizedBox(
                    height: 16,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            }
          }),
    );
  }
}