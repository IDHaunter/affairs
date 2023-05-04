import 'package:affairs/app/pages/tasks/tasks_list_widget_viewmodel.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/app/pages/tasks/tasks_list_widget.dart';

import '../../../core/data/hive/task.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentGroupKey =ModalRoute.of(context)!.settings.arguments as int;
    final TaskPageArguments newTaskPageArguments = TaskPageArguments(groupKey: currentGroupKey, curTask: Task(text: '', isDone: false, creationDate: DateTime.now()), taskKey: -1);
    //print('--- TasksPageState.build currentGroupKey=$currentGroupKey');

    return Scaffold(
        //backgroundColor: Colors.white,
        drawer: CustomNavigationDrawer(),
        body: Column(
          children: [
            TopBar(showCalendar: true, showFilter: true,showDatePicker: false),
            Expanded(
                child: ChangeNotifierProvider<TasksListWidgetViewModel>( //.value
                  //value: model,
                    create: (context) => TasksListWidgetViewModel(groupKey: currentGroupKey),
                    lazy: false,
                    child: TasksListWidget())
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MainNavigatorRouteNames.task, arguments: newTaskPageArguments);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
          },
          elevation: 5,
          tooltip: 'Добавить новую задачу',
          child: const Icon(color: Colors.white, Icons.add),
        ),
    );
  }
}
