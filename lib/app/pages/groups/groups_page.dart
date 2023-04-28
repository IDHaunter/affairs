import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/app/pages/groups/groups_list_widget.dart';
import '../../pages/groups/groups_list_widget_viewmodel.dart';

//import 'package:affairs/tests/learn_inherit.dart';
//import 'package:affairs/tests/learn_inherit_notifier.dart';
//import 'package:affairs/tests/learn_change_notifier_provider.dart';
//import 'package:affairs/tests/learn_shared_preferences.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: [
          TopBar(showCalendar: true, showFilter: true, showDatePicker: false),
          Expanded(
              child: ChangeNotifierProvider<GroupsListWidgetViewModel>(
                  create: (context) => GroupsListWidgetViewModel(),
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
          GroupPageArguments groupPageArguments = GroupPageArguments(groupIndex: -1, groupName: '');
          Navigator.of(context).pushNamed(MainNavigatorRouteNames.group, arguments: groupPageArguments);
          //context.read<DataGlobal>().putDataS(AppLocalizations.of(context)!.helloWorld); //пишет в модель
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: const Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}

