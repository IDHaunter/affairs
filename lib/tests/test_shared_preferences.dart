import 'package:affairs/core/common_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

//В начале функции main() необходимо добавить:
//WidgetsFlutterBinding.ensureInitialized();

//нужно определить ключи для хранения значений
const String spBoolKey = 'myBool';
const String spIntKey = 'myInt';

class TestSharedPreferences extends StatefulWidget {
  const TestSharedPreferences({Key? key}) : super(key: key);

  @override
  State<TestSharedPreferences> createState() => _TestSharedPreferencesState();
}

class _TestSharedPreferencesState extends State<TestSharedPreferences> {
  final Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  bool _boolValue=false;
  int _intValue=0;
  String _sExist = 'exist = ?';

  Future<void> _intChange(int iDif) async {
    final SharedPreferences sp = await _preferences;
    _intValue = (sp.getInt(spIntKey) ?? 0) + iDif;
    print(_intValue.toString());
    sp.setInt(spIntKey, _intValue);

    setState(() {
      print('setState _intChange');
    });
  }

  Future<void> _boolChange() async {
    final SharedPreferences sp = await _preferences;
    _boolValue = (sp.getBool(spBoolKey) ?? false) ? false : true;

    print('new boolean is $_boolValue');

    sp.setBool(spBoolKey, _boolValue);

    setState(() {
      print('setState _boolChange');
    });
  }

  Future<void> _boolExist() async {
    final SharedPreferences sp = await _preferences;
    _sExist = ('exist = ${sp.containsKey(spBoolKey)}');
    print(_sExist);

    setState(() {
      print('setState _boolExist');
    });
  }

  @override
  void initState() {
    super.initState();
    //then - означает что код выполнится только когда пройдёт инициализация
    _preferences.then((SharedPreferences sp) {
      _boolValue = sp.getBool(spBoolKey) ?? false;
      _intValue = sp.getInt(spIntKey) ?? 0;
      setState(() {
        print('setState init');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Column(
      children: [
        Row(children: [
          const SizedBox(
            width: 20,
          ),
         Text('BoolValue is $_boolValue'),
          const SizedBox(
            width: 20,
          ),
         ElevatedButton(onPressed: ()=>_boolChange(), child: const Text('Change')),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(onPressed: ()=>_boolExist(), child: Text(_sExist)),
        ],),
        Row(children: [
          const SizedBox(
            width: 20,
          ),
          Text('IntValue is $_intValue'),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(onPressed: () => _intChange(1), child: const Text('+1')),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(onPressed: (){ _intChange(-1); }, child: const Text('-1')),
        ],)
      ],
    );
  }
}




