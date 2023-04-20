import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/hive/task.dart';
import '../../../core/hive/box_handler.dart';

//В отличие от GroupPageModel тут мы не наследуемся от ChangeNotifier и используем через обычный Provider
//т.к. текст сообщения об ошибке мы делаем не через  errorText: Provider.of<GroupPageModel>(context, listen: true).errorText,
//а отображаем его через scaffold

class TaskPageModel /*extends ChangeNotifier*/ {
  int groupKey;
  int taskIndex;
  Task currentTask; //таска подлежащая редактированию
  String _taskText = '';
  DateTime? _taskDateTime;
  String? errorText;

  TaskPageModel({required this.groupKey, required this.taskIndex, required this.currentTask}) {
    //print(" ---- TaskPageModel.created");
  }

  set taskText(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      //notifyListeners();
    }
    _taskText = value.trim();
  }

  set taskDateTime(DateTime value) {
    _taskDateTime = value;
  }

  void saveTask() async {
    //Если текст не задан то выходим
    if (_taskText.isEmpty) {
      errorText = 'Текст задачи отсутствует';
      //notifyListeners();
      return;
    }

    final taskBox = boxHandler.taskBox;
    //Создаём Task
    final task = Task(text: _taskText, isDone: false, creationDate: DateTime.now(), taskDate: _taskDateTime);
    debugPrint('----------- saveTask ----  $_taskText -creationDate- ${DateTime.now()} -taskDate- $_taskDateTime');
    taskBox.add(task);

    final groupBox = boxHandler.groupBox;
    //Получаем группу по ключу
    final group = groupBox.get(groupKey);
    debugPrint('----------- saveTask ----  $groupKey');
    //Добавляем в группу Task
    group?.addTask(taskBox, task);
  }

  void editTask() async {
    //Если текст не задан то выходим
    if (_taskText.isEmpty) {
      errorText = 'Текст задачи отсутствует';
      //notifyListeners();
      return;
    }

    final taskBox = boxHandler.taskBox;
    //Модифицируем таску
    currentTask.text=_taskText;
    debugPrint('----------- editTask ---- taskKey=$taskIndex ---  ${currentTask.text} -creationDate- ${currentTask.creationDate} -taskDate- ${currentTask.taskDate}');

    //await taskBox.putAt(taskIndex, currentTask); - Работает по индексу
    final int taskKey = taskBox.keyAt(taskIndex);
    await taskBox.put(taskKey, currentTask);
  }

}
