import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/common_export.dart';
import '../../../core/hive/box_handler.dart';
import '../../../core/hive/group.dart';
import '../../../core/hive/task.dart';

class TasksListWidgetModel extends ChangeNotifier {
int groupKey;

bool isDisposed = false;

var _tasks = <Task>[];
List<Task> get tasks =>_tasks.toList();

Group? _group;
Group? get group => _group;

TasksListWidgetModel({required this.groupKey}){
  //print('--- TasksListWidgetModel = $groupKey ');
  _setup();
}

void refresh() {
  if (!isDisposed) {
    _readTasks();
    //notifyListeners();
  }
}

@override
void dispose() {
  isDisposed = true;
  super.dispose();
}

//Получение группы по ключу
void _loadGroup() async {
  final box = boxHandler.groupBox;
  _group = box.get(groupKey);
  //ВАЖНЫЙ МОМЕНТ: поскольку выполнение асинхронное то загрузка группы будет происходить с задержкой, и кто-то вызывающий
  //эту асинхронную функцию для получения группы может не дождаться милисекунды для получения группы.
  //Проблема решается через провайдер, подписку на номер группы и уведомление о её изменении и как следствие повторный build.
  notifyListeners();
}

  void _readTasks() async {
  final box = boxHandler.taskBox;

  //если либо бокс пустой либо в группе нет связей то возвращаем пустой лист
  if (box.length == 0) {_tasks = <Task>[];}
  else { _tasks = _group?.tasks ?? <Task>[]; }
  debugPrint('---- _readTasks ---- boxHandler.taskBox.length = ${box.length} ::: boxHandler.groupBox._tasks.length = ${_tasks.length} ');
  if (!isDisposed) {
    notifyListeners();
  }
  }

  void _setupListenTasks() async {
  _readTasks();

  //box.listenable().addListener(_refresh);
  //boxHandler.taskBox.listenable().addListener(_refresh);

  //идея в том, чтобы слушать изменения внутри бокса с группами только по определённой группе используя ключ groupKey
  //boxHandler.groupBox.listenable(keys: <dynamic>[groupKey]).addListener(_readTasks);
  boxHandler.taskBox.listenable().addListener(_readTasks);
  //если бы мы повесили слушателя на весь массив тасков или на всеь массив групп то при изменении любого элемента мы бы обновлялись
  //а так мы обновляемся только при изменении в одной группе
  }

  void deleteTask(int taskIndex) async {
    await _group?.tasks?.deleteFromHive(taskIndex);
    //при работе со связями обязательно после изменений нужно сохранять
    await _group?.save();
  }

  void doneToggle(int taskIndex) async {
  final task = _group?.tasks?[taskIndex];
  final currentState = task?.isDone ?? false;
  task?.isDone = !currentState;
  await task?.save();
  notifyListeners();
  }

  void _setup( ) {
    _loadGroup();
    _setupListenTasks();
  }

}