import 'package:affairs/app/pages/tasks/tasks_list_widget_model.dart';
import 'package:affairs/core/common_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('---_TasksListWidgetState.build before tasksCount');
    final int tasksCount = Provider.of<TasksListWidgetModel>(context, listen: true).tasks.length;
    //print('---_TasksListWidgetState.build tasksCount= $tasksCount');

    return Column(children: [
      const SizedBox(height: 5),
      Text(
        Provider.of<TasksListWidgetModel>(context, listen: true).group?.name ?? 'Список задач',
        style: regular.copyWith(fontSize: titleSize),
      ),
      Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return TasksListRowWidget(indexInList: index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
              );
            },
            itemCount: tasksCount),
      ),
    ]);
  }
}

class TasksListRowWidget extends StatelessWidget with DefaultBackColor {
  final int indexInList;

  TasksListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TasksListWidgetModel>(context, listen: false).tasks[indexInList];

    //иконка и текст будут зависить от статуса таски
    final icon = task.isDone ? Icons.done : null;
    final taskTextStyle = task.isDone ? medium.copyWith(decoration: TextDecoration.lineThrough) : medium;
    final String sCreationDate = DateFormat("dd.MM.yyyy").format(task.creationDate);
    final String sTaskDate = (task.taskDate==null) ? '' : DateFormat("dd.MM.yyyy").format(task.taskDate!);
    final creationDateStyle = medium.copyWith(color: curITheme.textSecondary(), fontSize: 12);
    final taskDateStyle = medium.copyWith(color: curITheme.primary(), fontSize: 12);

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      //key: const ValueKey(0),
      // The start action pane is the one at the left or the top side.
//      startActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
//        motion: const ScrollMotion(),

      // A pane can dismiss the Slidable.
      //dismissible: DismissiblePane(onDismissed: () {}),

      // All actions are defined in the children parameter.
//        children:  [

      // SlidableAction(
      //   // An action can be bigger than the others.
      //   flex: 2,
      //   onPressed:(context){},
      //   backgroundColor: Color(0xFF7BC043),
      //   foregroundColor: Colors.white,
      //   icon: Icons.archive,
      //   label: 'Archive',
      // ),
      // SlidableAction(
      //   onPressed: (context){},
      //   backgroundColor: Color(0xFF0392CF),
      //   foregroundColor: Colors.white,
      //   icon: Icons.save,
      //   label: 'Save',
      // ),

//        ],
//      ),

      //The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: curITheme.majorShadow(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.drive_file_rename_outline,
            //label: 'Rename',
          ),
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              Provider.of<TasksListWidgetModel>(context, listen: false).deleteTask(indexInList);
              //print('----delete: $indexInList');
            },
            backgroundColor: curITheme.accent(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.delete,
            //label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Row(
            children: [
              Text(sCreationDate, style: creationDateStyle),
              const SizedBox(width: 12),
              Text(sTaskDate, style: taskDateStyle),
            ],
          ),
            Text(task.text, style: taskTextStyle),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Icon(icon),
        ),
        // trailing:  CircleAvatar(
        //   backgroundColor: Color.fromRGBO(r, g, b, 0.2),
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(icon),
        //     color: Colors.white,
        //   ),
        // ),
        onTap: () {
          Provider.of<TasksListWidgetModel>(context, listen: false).doneToggle(indexInList);
          //Navigator.of(context).pushNamed('/tasks_page', arguments: Provider.of<GroupsListWidgetModel>(context, listen: false).takeGroupKey);
        },
      ),
    );
  }
}
