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

//Стейтфул нужен чтобы хранить модель
class PSimpleCalcWidget extends StatefulWidget {
  const PSimpleCalcWidget({Key? key}) : super(key: key);

  @override
  State<PSimpleCalcWidget> createState() => _PSimpleCalcWidgetState();
}

class _PSimpleCalcWidgetState extends State<PSimpleCalcWidget> {

  @override
  Widget build(BuildContext context) {
    //в качестве чайлда нужен отдельный виджет чтобы в его билд передать контекст
    //с SimpleCalcProvider и его моделью данных,
    return ChangeNotifierProvider(
      create: (context) => PSimpleCalcModel(),
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
