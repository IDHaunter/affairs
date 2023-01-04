import 'package:affairs/app/pages/tasks/tasks_list_widget_model.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/app/pages/tasks/tasks_list_widget.dart';
import '../task/task_page_model.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentGroupKey =ModalRoute.of(context)!.settings.arguments as int;
    //print('--- TasksPageState.build currentGroupKey=$currentGroupKey');

    return Provider<TaskPageModel>(
      create: (context) => TaskPageModel(groupKey: currentGroupKey),
      lazy: false,
      child: Scaffold(
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
            print(' ---- Floating OnPressed ');
            Navigator.of(context).pushNamed(MainNavigatorRouteNames.task, arguments: currentGroupKey);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
          },
          elevation: 5,
          tooltip: 'Добавить новую задачу',
          child: const Icon(color: Colors.white, Icons.add),
        ),
      ),
    );
  }
}
