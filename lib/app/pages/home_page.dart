import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          TopBar(),
          //Text(context.watch<String>()) - для обычного провайдера
          Text(context.watch<DataGlobal>().getDataS),
          SizedBox(
            height: 20,
          ),
          SomeDataS(),
          SizedBox(
            height: 20,
          ),
          DataProviderInherited(
              value: 1000,
              child: ShowMeAll()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DataGlobal>().changeString(AppLocalizations.of(context)!.helloWorld);
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}

class SomeDataS extends StatelessWidget {
  const SomeDataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (newData) => context.read<DataGlobal>().changeString(newData));
  }
}

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
  bool updateShouldNotify(DataProviderInherited old) {
    //если предыдущее и текущее значения разные, то true (нужно обновлять) иначе false
    return value != old.value;
  }
}

class ShowMeAll extends StatelessWidget {
  const ShowMeAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //получаем и подписываемся на изменения
    //т.е. если инхерит переконструеруется и изменит свои данные, то вызовется и этот build
    //даже если этот класс будет const что хорошо для оптимизации
    int i = context.dependOnInheritedWidgetOfExactType<DataProviderInherited>()?.value ?? 0;

    return Text('das auto $i');
  }
}
