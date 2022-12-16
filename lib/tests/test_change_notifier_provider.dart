import 'package:affairs/core/common_export.dart';

class PSimpleCalcModel extends ChangeNotifier {
  int _firstNumber = 0;
  int _secondNumber = 0;
  int sumResult = 0;

  set putFirstNumber(String sValue) {
    print('putFirstNumber' + sValue);
    _firstNumber = int.tryParse(sValue) ?? 0;
  }

  set putSecondNumber(String sValue) {
    print('putSecondNumber' + sValue);
    _secondNumber = int.tryParse(sValue) ?? 0;
  }

  get takeSumResult {
    print('takeSumResult=$sumResult');
    return sumResult;
  }

  void calcSum() {
    sumResult = _firstNumber + _secondNumber;
    print('calcSum $sumResult');
    notifyListeners();
  }
}

//Стейтфул нужен чтобы хранить модель не нужен! Этим занимается провайдер!
class PSimpleCalcWidget extends StatelessWidget {
  const PSimpleCalcWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //в качестве чайлда нужен отдельный виджет чтобы в его билд передать контекст
    //а ChangeNotifierProvider инициализирует и сохранит модель данных,
    //т.е. возьмёт на себя функции state как в stateful
    //final model=PSimpleCalcModel(); модель можно инициализировать самому, и использовать именной конструктор (.value)
    //ChangeNotifierProvider.value(value: model, child: ...,) - если нужно передать модель на другой экран
    //но тогда создавать и уничтожать модель нужно самому...
    //если же использовать просто Provider вместо ChangeNotifierProvider то появляется возможность использовать select
    //select это аналог watch но отслеживается только изменение конкретного одного параметра
    //но для обычного provider код модели данных будет гораздо больше и будет похож на inherit
    //Provider вместо ChangeNotifierProvider нужно использовать для комплексных сложных моделей данных
    //т.е. там не просто переменные вложенные классы с кучей виджетов, иначе перегрузим приложение
    return ChangeNotifierProvider(
      create: (context) => PSimpleCalcModel(),
      lazy: true, //true-создаст модель в памяти при первом обращении, false - сразу
      child: const PCalcArea(),
    );
  }
}

class PCalcArea extends StatelessWidget {
  const PCalcArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //read!!!! только читаем
    final model = context.read<PSimpleCalcModel>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 100,
                height: 46,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (newValue) {
                    context.read<PSimpleCalcModel>().putFirstNumber = newValue;
                  },
                )),
            Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('+')),
            Container(
                width: 100,
                height: 46,
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (newValue) {
                    context.read<PSimpleCalcModel>().putSecondNumber = newValue;
                  },
                )),
            Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('=')),
            Container(padding: EdgeInsets.symmetric(horizontal: 10), child: PResultWidget()),
          ],
        ),
        Consumer<PSimpleCalcModel>(
        //builder - это функция которая вызовется при изменинии модели данных DataGlobal
        builder: (context, //собственно контекст
                  calcModel, //переменная с нашей моделью
                  child) {    //для оптимимзации, если нужен тяжёлый виджет по дереву ниже не нуждающийся в обновлении
        return Text('Result using consumer widget is ${calcModel.takeSumResult}');
        },
        ),
        // Пример структуры с тяжёлым виджетом:
        // Consumer<DataGlobal>(
        //   builder: (context, dataGlobal, child) => Stack(
        //     children: [
        //       // Use SomeExpensiveWidget here, without rebuilding every time.
        //       if (child != null) child,
        //       Text('Result using consumer widget is ${dataGlobal.takeDataS}'),
        //     ],
        //   ),
        //   // Build the expensive widget here.
        //   child: const SomeExpensiveWidget(),
        // ),
        ElevatedButton(
            onPressed: () {
              print('pressed');
              model.calcSum();
            },
            child: const Text('Calculate!')),
      ],
    );
  }
}

class PResultWidget extends StatelessWidget {
  const PResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.watch<PSimpleCalcModel>().sumResult;
    return Text(value.toString());
  }
}

//------------------------------------------------------------------------------
class SomeDataTest extends StatelessWidget {
  const SomeDataTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //две строчки аналогичны
        Text(context.watch<DataGlobal>().takeDataS), //смотрит за моделью
        Text(Provider.of<DataGlobal>(context, listen: true).takeDataS), //смотрит за моделью
        const SizedBox(
          height: 20,
        ),
        const SomeDataS(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class SomeDataS extends StatelessWidget {
  const SomeDataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (newData) =>
            //Эти две строки аналогичны
            Provider.of<DataGlobal>(context, listen: false).putDataS(newData)); //пишет в модель
    //   context.read<DataGlobal>().changeString(newData)); //пишет в модель
  }
}
