//----------------------------------------------------------------------------------------------------------------------
//Использование без async и await т.е. выполнение абсолютно нелинейное, труднопрогнозируемое

Future<String> getWeatherForecast() {
  return Future.delayed(Duration(seconds: 2), () => "Partly cloudy");
}

void fetchWeatherForecast() {
  print("start: fetchWeatherForecast");
  final forecast = getWeatherForecast();
  forecast.then(
        (value) => print("fetchWeatherForecast: $value"),

  );
  print("end: fetchWeatherForecast");
}

void testMain(List<String> arguments) {
  print('start: main');
  fetchWeatherForecast();
  print('end: main');
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
  print("start: fetchWeatherForecast");
  final forecast = await getWeatherForecast();
  print("fetchWeatherForecast: $forecast");
  print("end: fetchWeatherForecast");
}

void testMain2(List<String> arguments) {
  print('start: main');
  fetchWeatherForecast2();
  print('end: main');
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

  print("start: fetchWeatherForecast");
  final forecast = await getWeatherForecast();

  print("fetchWeatherForecast: $forecast");
  print("end: fetchWeatherForecast");
}

void main(List<String> arguments) async {
  print('start: main');
  await fetchWeatherForecast3();
  print('end: main');
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