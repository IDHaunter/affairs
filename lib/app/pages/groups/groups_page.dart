import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/app/pages/groups/groups_list_widget.dart';
import '../../pages/groups/groups_list_widget_model.dart';

//import 'package:affairs/tests/test_inherit.dart';
//import 'package:affairs/tests/test_inherit_notifier.dart';
//import 'package:affairs/tests/test_change_notifier_provider.dart';
//import 'package:affairs/tests/test_shared_preferences.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          TopBar(),
          Expanded(
              child: ChangeNotifierProvider<GroupsListWidgetModel>(
                  create: (context) => GroupsListWidgetModel(),
                  child: GroupsListWidget())
              ),
          //TestSharedPreferences(),
          //Text(context.watch<String>()) - для обычного провайдера
          //SomeDataTest(),
          //TestInherit(),      //просто inherit - вниз по дереву
          //SimpleCalcWidget(), //через inherit notifier
          //PSimpleCalcWidget(), //через провайдер
          //TestInheritNotifier(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //showGroupPage(context);
          Navigator.of(context).pushNamed('/group_page');
          //context.read<DataGlobal>().putDataS(AppLocalizations.of(context)!.helloWorld); //пишет в модель
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: const Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}

