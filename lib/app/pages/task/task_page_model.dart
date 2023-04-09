import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/hive/task.dart';
import '../../../core/hive/box_handler.dart';

class TaskPageModel /*extends ChangeNotifier*/ {
  int groupKey;
  String _taskText = '';
  DateTime? _taskDateTime;
  String? errorText;

  TaskPageModel({required this.groupKey})
  {
    //print(" ---- TaskPageModel.created");
  }

  set taskText (String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      //notifyListeners();
    }
    _taskText = value.trim();
  }

  set taskDateTime (DateTime value) {
    _taskDateTime=value;
  }

  void saveTask() async {
    //Если текст не задан то выходим
    if (_taskText.isEmpty) {
      errorText='Текст задачи отсутствует';
      //notifyListeners();
      return;};

    final taskBox = boxHandler.taskBox;
    //Создаём Task
    final task= Task(text: _taskText, isDone: false, creationDate: DateTime.now() ,taskDate: _taskDateTime);
    debugPrint('-----------   ----  $_taskText -creationDate- ${DateTime.now()} -taskDate- $_taskDateTime');
    taskBox.add(task);

    final groupBox = boxHandler.groupBox;
    //Получаем группу по ключу
    final group = groupBox.get(groupKey);
    //Добавляем в группу Task
    group?.addTask(taskBox, task);

  }
}
