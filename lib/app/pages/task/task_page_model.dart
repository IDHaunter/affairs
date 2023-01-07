import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive/hive.dart';

import 'package:affairs/core/entity/task.dart';

import '../../../core/entity/box_handler.dart';

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

    final taskBox = boxHandler.taskBox;
    //Создаём Task
    final task= Task(text: taskText, isDone: false);
    taskBox.add(task);

    final groupBox = boxHandler.groupBox;
    //Получаем группу по ключу
    final group = groupBox.get(groupKey);
    //Добавляем в группу Task
    group?.addTask(taskBox, task);

  }
}
