import 'package:affairs/core/common_export.dart';

//Обычный inherit подразумевает полное обновление всех подписаных виджетов при изменении хоть одного параметра
//информация передаётся только по дереву ниже инхерита и только при пересоздании инхерита
class DataProviderInherited extends InheritedWidget {
  final int value;
  const DataProviderInherited({
    Key? key,
    required this.value,
    required Widget child,
  }) : super(key: key, child: child);

  static DataProviderInherited of(BuildContext context) {
    final DataProviderInherited? result =
    context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
    assert(result != null, 'No DataProviderInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    //если предыдущее и текущее значения разные, то true (нужно обновлять) иначе false
    return value != oldWidget.value;
  }
}

//inherit model допускает частичное обновление всех подписаных виджетов при изменении хоть одного параметра
class DataProviderInherited2 extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;
  const DataProviderInherited2({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DataProviderInherited2 oldWidget) {
    //если предыдущее и текущее значения разные, то true (нужно обновлять) иначе false
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo ;
  }

  @override
  bool updateShouldNotifyDependent(covariant DataProviderInherited2 oldWidget, Set<String> dependencies) {
    // TODO: implement updateShouldNotifyDependent
    final isValueOneUpdated = valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdated = valueTwo != oldWidget.valueTwo && dependencies.contains('two');
    return isValueOneUpdated || isValueTwoUpdated;
  }
}

class ShowMeAll1 extends StatelessWidget {
  const ShowMeAll1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //получаем и подписываемся на изменения
    //т.е. если инхерит переконструеруется и изменит свои данные, то вызовется и этот build
    //даже если этот класс будет stateless и const, что очень хорошо для оптимизации
    int i = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>()?.value ?? 0;

    return Text('InheritedWidget = $i');
  }
}

class ShowMeAll2 extends StatelessWidget {
  const ShowMeAll2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //подписываемся через модель используя аспекты, т.е. потенциально пподписчики на определённый аспект обновляются
    // только при измении аспекта
    int i = context.dependOnInheritedWidgetOfExactType<DataProviderInherited2>(aspect: 'one')?.valueOne ?? 0;
    int j = context.dependOnInheritedWidgetOfExactType<DataProviderInherited2>(aspect: 'two')?.valueTwo ?? 0;
    return Text('InheritedModel aspect one = $i aspect two = $j');
  }
}

class TestInherit extends StatefulWidget {
  const TestInherit({Key? key}) : super(key: key);

  @override
  State<TestInherit> createState() => _TestInheritState();
}

class _TestInheritState extends State<TestInherit> {
  int _valueOne=10;
  int _valueTwo=20;

  void onePressed() {
    _valueOne = _valueOne + 1;
    setState(() {
    });
  }

  void twoPressed() {
    _valueTwo = _valueTwo + 1;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(onPressed: onePressed, child: const Text('Value One Up')),
          SizedBox(width: 20,),
          ElevatedButton(onPressed: twoPressed, child: const Text('Value Two Up')),
        ],),

        SizedBox(
          height: 20,
        ),
        DataProviderInherited2( // DataProviderInherited(
            valueOne: _valueOne,
            valueTwo: _valueTwo,
            child: ShowMeAll2()),
        SizedBox(
          height: 20,
        ),
        DataProviderInherited( // DataProviderInherited(
            value: _valueOne,
            child: ShowMeAll1()),
      ],
    );
  }
}

//----------------------------------------------------------------------------------------------------------------------
class SimpleCalcModel extends ChangeNotifier {
int _firstNumber=0;
int _secondNumber=0;
int sumResult=0;

set putFirstNumber(String sValue) {
  print('putFirstNumber' + sValue);
  _firstNumber = int.tryParse(sValue) ?? 0; }
set putSecondNumber(String sValue) {
  print('putSecondNumber' + sValue);
  _secondNumber = int.tryParse(sValue) ?? 0; }
get takeSumResult {
  print('takeSumResult=$sumResult' );
  return sumResult;}

void calcSum() {
  sumResult =  _firstNumber + _secondNumber;
  print('calcSum $sumResult');
  notifyListeners();
}

}

//InheritedNotifier - не требует updateShouldNotify т.к. ему в параметр notifier: уже передали зачем нужно следить
//в будущем использование пакета Provider поможет избежать  вот этого объявления и позволяет работать со stream и future
class SimpleCalcProvider extends InheritedNotifier <SimpleCalcModel> {
  final SimpleCalcModel model;
   const SimpleCalcProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  //Эта функция является синтаксическим упрощением (сахаром) для dependOnInheritedWidgetOfExactType<SimpleCalcWidgetProvider>
  static SimpleCalcModel? watch(BuildContext context) {
    // dependOnInheritedWidgetOfExactType - подписывает на изменения и ребилдит того кто её вызывает при изменении модели данных
    return context.dependOnInheritedWidgetOfExactType<SimpleCalcProvider>()?.notifier;
  }

  static SimpleCalcModel? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<SimpleCalcProvider>()?.widget;
    // getElementForInheritedWidgetOfExactType - просто читает из модели данных (не подписывая на изменения!!!)
    return widget is SimpleCalcProvider ? widget.notifier : null;
  }

}

//Стейтфул нужен чтобы хранить модель
class SimpleCalcWidget extends StatefulWidget {
  const SimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalcWidget> createState() => _SimpleCalcWidgetState();
}

class _SimpleCalcWidgetState extends State<SimpleCalcWidget> {
  final _model = SimpleCalcModel();

  @override
  Widget build(BuildContext context) {
    return SimpleCalcProvider(
      model: _model,
      //в качестве чайлда нужен отдельный виджет чтобы в его билд передать контекст
      //с SimpleCalcProvider и его моделью данных,
      //иначе dependOnInheritedWidgetOfExactType<SimpleCalcProvider> ничего не найдёт
      child: CalcArea(),
    );
  }
}

class CalcArea extends StatelessWidget {
  const CalcArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 100, height: 46, child: TextField(decoration: InputDecoration( border: OutlineInputBorder()), onChanged: (newValue) {
            SimpleCalcProvider.read(context)?.putFirstNumber=newValue;
          },)),
          Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('+')),
          SizedBox(width: 100, height: 46, child: TextField(decoration: InputDecoration(border: OutlineInputBorder()), onChanged: (newValue) {
            SimpleCalcProvider.read(context)?.putSecondNumber=newValue;
          },)),
          Container(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('=')),
          Container(padding: EdgeInsets.symmetric(horizontal: 10), child: ResultWidget()),
        ],
      ),
        ElevatedButton( onPressed: () {
          print('pressed');
          SimpleCalcProvider.read(context)?.calcSum;
          context.dependOnInheritedWidgetOfExactType<SimpleCalcProvider>()?.model.calcSum();
        } ,
            child: const Text('Calculate!')),
      ],
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = SimpleCalcProvider.watch(context)?.sumResult ?? '-1';
    //final ss = SimpleCalcWidgetProvider.of(context)?.takeSumResult.toString() ?? '-2';
    return Text(value.toString());
  }
}


