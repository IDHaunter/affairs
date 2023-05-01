import 'package:affairs/core/data/hive/task.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';
//https://docs.hivedb.dev/#/custom-objects/generate_adapter
//flutter packages pub run build_runner watch
//Запустив эту команду мы сгенерируем group.g.dart (адаптер) плюс он будет
//автоматически перегенироваться
@HiveType(typeId: 1)
class Group extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  //HiveList - используется для хранения связей
  //Честно говоря в этом проекте две одинаковые таски в разных группах быть не может, и вместо связей и дополнительного
  //бокса tasks можно было обойтись просто List<Task> tasks, но мы не ищем простых путей и будем хранить именно связь
  //к слову говоря если бы этих связей было гораздо больше то проще было бы использовать SQLite (ниже производительность)
  HiveList<Task>? tasks;

  Group({required this.name});

  //Добавлялка связи - при условии что у нас уже есть box со связываемыми тасками Box<Task> и сама таска Task
  void addTask (Box<Task> box, Task task) {
    tasks ??= HiveList(box); //если Null то присваиваем ему Box
    tasks?.add(task);
    //Если в рантайме сохраняется а при перезапуске отсутствует то нужно сохранить
    //т.к. при работе со списком связей (HiveList) обязательно после изменений нужно сохранять
    save();
  }
}