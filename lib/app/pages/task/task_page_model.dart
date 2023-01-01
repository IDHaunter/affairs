import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive/hive.dart';

import 'package:affairs/core/entity/task.dart';

class TaskPageModel {
  int groupKey;
  var taskText = '';

  TaskPageModel({required this.groupKey})
  {
    print(" ---- TaskPageModel.created");
  }

  void saveTask(BuildContext context) async {
    //Если текст не задан то выходим
    if (taskText.isEmpty) return;

    //Тут нам потребуется два адаптера
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }

    final taskBox = await Hive.openBox<Task>('tasks_box');
    //Создаём Task
    final task= Task(text: taskText, isDone: false);
    taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('group_box');
    //Получаем группу по ключу
    final group = groupBox.get(groupKey);
    //Добавляем в группу Task
    group?.addTask(taskBox, task);

  }
}
