import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
//import 'package:affairs/tests/test_inherit.dart';
//import 'package:affairs/tests/test_inherit_notifier.dart';
import 'package:affairs/tests/test_change_notifier_provider.dart';

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
          Text(context.watch<DataGlobal>().getDataS), //смотрит за моделью
          SizedBox(
            height: 20,
          ),
          SomeDataS(),
          SizedBox(
            height: 20,
          ),
          //TestInherit(),      //просто inherit - вниз по дереву
          //SimpleCalcWidget(), //через inherit notifier
          PSimpleCalcWidget(),   //через провайдер
          //TestInheritNotifier(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DataGlobal>().changeString(AppLocalizations.of(context)!.helloWorld); //пишет в модель
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
    return TextField(onChanged: (newData) => context.read<DataGlobal>().changeString(newData)); //пишет в модель
  }
}


