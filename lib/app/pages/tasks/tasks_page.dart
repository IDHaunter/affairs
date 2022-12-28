import 'package:affairs/app/pages/tasks/tasks_list_widget_model.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/app/pages/tasks/tasks_list_widget.dart';

import '../groups/groups_list_widget_model.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);
  //late final int currentGroupKey;
  //late final TasksListWidgetModel model;

  @override
  Widget build(BuildContext context) {
    //final groupKey = ModalRoute.of(context)!.settings.arguments as int;

    //модель TasksListWidgetModel по группе нужно инициализировать до первого обращения
    final currentGroupKey =ModalRoute.of(context)!.settings.arguments as int;
    //print('--- TasksPageState.build currentGroupKey=$currentGroupKey');
    //model=TasksListWidgetModel(groupKey: currentGroupKey);

    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          TopBar(),
          Expanded(
              child: ChangeNotifierProvider<TasksListWidgetModel>( //.value
                //value: model,
                  create: (context) => TasksListWidgetModel(groupKey: currentGroupKey),
                  lazy: false,
                  child: TasksListWidget())
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/tasks_page/task_page');
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: const Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}
