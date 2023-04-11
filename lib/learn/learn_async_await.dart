//----------------------------------------------------------------------------------------------------------------------
//Использование без async и await т.е. выполнение абсолютно нелинейное, труднопрогнозируемое

import '../core/common_export.dart';

Future<String> getWeatherForecast() {
  return Future.delayed(const Duration(seconds: 2), () => "Partly cloudy");
}

void fetchWeatherForecast() {
  debugPrint("start: fetchWeatherForecast");
  final forecast = getWeatherForecast();
  forecast.then(
        (value) => debugPrint("fetchWeatherForecast: $value"),

  );
  debugPrint("end: fetchWeatherForecast");
}

void testMain(List<String> arguments) {
  debugPrint('start: main');
  fetchWeatherForecast();
  debugPrint('end: main');
}

//Результат:
// start: main
// start: fetchWeatherForecast
// end: fetchWeatherForecast
// end: main
// --- ожидание 2 секунды
// fetchWeatherForecast: Partly cloudy

//----------------------------------------------------------------------------------------------------------------------
// у async две функции:
// 1. превращение любой функции в асинхронную
// 2. оборачивание возвращаемого значения в тип Future. Т.е. явно делать return Future.value(XXX) не нужно, достаточно return value(XXX)
// ПРИМЕЧАНИЕ: любую синронную функцию можно обернуть в async без ошибки
// await нужен чтобы заставить выполниться асинхронное действие до того как приступить к следующему
// ПРИМЕЧАНИЕ: внутри async функции после await всё будет последовательно, но вызов самой async функции без await не будет последовательным

Future<void> fetchWeatherForecast2() async {
  debugPrint("start: fetchWeatherForecast");
  final forecast = await getWeatherForecast();
  debugPrint("fetchWeatherForecast: $forecast");
  debugPrint("end: fetchWeatherForecast");
}

void testMain2(List<String> arguments) {
  debugPrint('start: main');
  fetchWeatherForecast2();
  debugPrint('end: main');
}

// результат:
// start: main
// start: fetchWeatherForecast
// end: main
// --- ожидание 2 секунды
// fetchWeatherForecast: Partly cloudy
// end: fetchWeatherForecast

//В результате внутри fetchWeatherForecast2 всё происходит последовательно а в main асинхронно т.к. fetchWeatherForecast2 асинхронная
//----------------------------------------------------------------------------------------------------------------------
//Далее заставим все вызовы выполняться последовательно в обоих функциях:

Future<void> fetchWeatherForecast3() async {

  debugPrint("start: fetchWeatherForecast");
  final forecast = await getWeatherForecast();

  debugPrint("fetchWeatherForecast: $forecast");
  debugPrint("end: fetchWeatherForecast");
}

void main(List<String> arguments) async {
  debugPrint('start: main');
  await fetchWeatherForecast3();
  debugPrint('end: main');
}

// результат:
// start: main
// start: fetchWeatherForecast
// fetchWeatherForecast: Partly cloudy
// end: fetchWeatherForecast
// end: main
//----------------------------------------------------------------------------------------------------------------------

//ВЫВОДЫ:
//1. Асинхронная функция это функция которая возвращает тип Future и ждать такую функцию без await никто не будет
//2. Мы добавляем await перед асинхронной функцией чтобы дождаться её выполнения до того как перейти к след. строке кода
//3. Мы добавляем async перед телом функции чтобы пометить что функция поддерживает await
//4. async функция автоматически обернёт возвращаемое значение в Future если это не сделано явно в коде

//----------------------------------------------------------------------------------------------------------------------
//Иногда есть необходимость передать внутрь асинхронной функции то что внутри её запрещено выполнять, например работу с контекстом
//Такая проблема решается двумя способами:
//1. встроеный CallBack внутрь асинхронной функции и проверка  if (!mounted) в Stateful

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => const MyCustomClass().myAsyncMethod(context, () {
        if (!mounted) return; //это работает только в Stateful !!!
        Navigator.of(context).pop();
      }),
      icon: const Icon(Icons.bug_report),
    );
  }
}

//2. Обман компилятора в stateless или ином классе
class Deception {
  void bar(BuildContext context, [bool mounted = true]) async {
    await getWeatherForecast();
    if (!mounted) return;
    Navigator.pop(context);
  }
}
