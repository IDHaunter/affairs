import 'package:affairs/core/entity/task.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';
//flutter packages pub run build_runner watch
//Запустив эту команду мы сгенерируем group.g.dart (адаптер) плюс он будет
//автоматически перегенироваться
@HiveType(typeId: 1)
class Group extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  //HiveList - используется для хранения связей
  HiveList<Task>? tasks;

  Group({required this.name});

  void addTask (Box<Task> box, Task task) {
    tasks ??= HiveList(box); //если Null то присваиваем ему Box
    tasks?.add(task);
    //Если в рантайме сохраняется а при перезапуске отсутствует то нужно сохранить
    //т.к. при работе со списком связей (HiveList) обязательно после изменений нужно сохранять
    save();
  }
}