import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/hive/task.dart';
import '../../../core/hive/box_handler.dart';

//В отличие от GroupPageModel тут мы не наследуемся от ChangeNotifier и используем через обычный Provider
//т.к. текст сообщения об ошибке мы делаем не через  errorText: Provider.of<GroupPageModel>(context, listen: true).errorText,
//а отображаем его через scaffold

class TaskPageModel /*extends ChangeNotifier*/ {
  int groupKey;
  int taskKey;
  Task currentTask; //таска подлежащая редактированию
  String _taskText = '';
  DateTime? _taskDateTime;
  String? errorText;

  TaskPageModel({required this.groupKey, required this.taskKey, required this.currentTask}) {
    //print(" ---- TaskPageModel.created");
    fillTaskText(currentTask.text);
  }

  void fillTaskText(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      //notifyListeners();
    }
    _taskText = value.trim();
  }

  set taskText(String value) {
    fillTaskText(value);
  }

  set taskDateTime(DateTime? value) {
    _taskDateTime = value;
  }

  void addTask() async {
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
    //Модифицируем таску используя непосредственно переданную таску
    //ВНИМАНИЕ: любая таска унаследованая от HiveObject является ссылкой синглтоном на реальную таску
    debugPrint('----------- editTask ---- taskKey=$taskKey ---- taskText= ${currentTask.text} -creationDate- ${currentTask.creationDate} -taskDate- ${currentTask.taskDate}');
    currentTask.text=_taskText;
    currentTask.taskDate = _taskDateTime;
    await taskBox.put(taskKey, currentTask);

    //КОД ДУБЛЁР!!! - модификация таски по ключу
    //ВНИМАНИЕ: Если попытаться принести тот же объект (наследуемый от HiveObject) из других виджетов и добавить его здесь дважды
    // (как currentTask и task2edit) в данном случае, то будет ошибка The same instance of an HiveObject cannot be stored with two different keys

    //final task2edit = taskBox.get(taskKey);
    //task2edit!.text = _taskText;
    //task2edit!.taskDate = _taskDateTime;
    //await taskBox.put(taskKey, task2edit);

    //await taskBox.put(taskKey, currentTask); - вызовет ошибку HiveError: The same instance of an HiveObject cannot be stored with two different keys
    //await taskBox.putAt(taskIndex, currentTask); - дважды положить по индексу будет ошибка
  }

}
