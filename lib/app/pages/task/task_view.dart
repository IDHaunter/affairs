import 'package:affairs/app/pages/task/task_viewmodel.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

import '../../../core/data/hive/task.dart';

class TaskView extends StatelessWidget {
  final int groupKeyFromNavigator;
  final int taskKeyFromNavigator;
  final Task taskFromNavigator;

  const TaskView({
    Key? key,
    required this.groupKeyFromNavigator,
    required this.taskFromNavigator,
    required this.taskKeyFromNavigator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('---- TaskPage.build groupKeyFromNavigator=$groupKeyFromNavigator');
    //final currentGroupKey = ModalRoute.of(context)!.settings.arguments as int; - при работе через свой навигатор (MainNavigator) будет = null !!!

    return Provider<TaskViewModel>(
        //ChangeNotifier
        create: (context) => TaskViewModel(
            groupKey: groupKeyFromNavigator, currentTask: taskFromNavigator, taskKey: taskKeyFromNavigator),
        lazy: false,
        child: const TaskPageWidget());
  }
}

class TaskPageWidget extends StatelessWidget {
  const TaskPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('---- TaskPageWidget.build');
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(
              showCalendar: false,
              showFilter: false,
              showDatePicker: true,
              editDate: Provider.of<TaskViewModel>(context, listen: false).currentTask.taskDate,
              title: (Provider.of<TaskViewModel>(context, listen: false).currentTask.text == '')
                  ? context.l()!.newTask
                  : context.l()!.editTask,
              filterDefault: context.l()!.noFilter,
              dateDefault: context.l()!.noDate),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: context.screenHeight() > context.screenWidth() ? 10 : 0, horizontal: 10),
            child: TaskTextWidget(initialTask: Provider.of<TaskViewModel>(context, listen: false).currentTask),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Provider.of<TaskViewModel>(context, listen: false).currentTask.text == '') {
            //Если входная таска была пустой то значит это внесение новой таски
            Provider.of<TaskViewModel>(context, listen: false).addTask();
          } else {
            //редактирование таски
            Provider.of<TaskViewModel>(context, listen: false).editTask();
            //Provider.of<TasksListWidgetModel>(context, listen: false).refresh();
          }

          if (Provider.of<TaskViewModel>(context, listen: false).errorText != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: themeHandler.currentITheme.secondary(),
                content: Text(
                  Provider.of<TaskViewModel>(context, listen: false).errorText!,
                  style: regular.copyWith(color: curITheme.failure()),
                )));
          } else {
            //возвращаемся на предыдущую страницу
            Navigator.of(context).pop();
          }
        },
        elevation: 5,
        child: const Icon(color: Colors.white, Icons.done),
      ),
    );
  }
}

class TaskTextWidget extends StatefulWidget {
  final Task initialTask;

  const TaskTextWidget({Key? key, required this.initialTask}) : super(key: key);

  @override
  State<TaskTextWidget> createState() => _TaskTextWidgetState();
}

class _TaskTextWidgetState extends State<TaskTextWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTask.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      //textAlign: TextAlign.center,
      style: regular.copyWith(fontSize: titleSize),
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: InputDecoration(
        //contentPadding: EdgeInsets.symmetric(horizontal: 25),
        //border: OutlineInputBorder(),
        border: InputBorder.none,
        hintText: context.l()!.taskText,
        //hintStyle: basic,
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) => Provider.of<TaskViewModel>(context, listen: false).taskText = value,
      controller: _controller,
    );
  }
}
