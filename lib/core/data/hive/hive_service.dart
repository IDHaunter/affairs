//Создание экземпляра сервиса для Hive и всех используемых коллекций (box)
import 'package:affairs/core/data/hive/task.dart';
import 'package:hive/hive.dart';
import '../../common_export.dart';
import 'group.dart';

//Собственно сервис
class HiveService {
  late final Box<Group> _groupBox;
  late final Box<Task> _taskBox;

  Box<Group> get groupBox => _groupBox;

  Box<Task> get taskBox => _taskBox;

  //Должен существовать в единственном экземпляре, поэтому конструируется через
  //спец конструктор _internal() и затем экземпляр просто возвращается через factory
  static final HiveService instance = HiveService._internal();

  //собственно фабрика для гарантирования инициализации одного экземпляра instance
  factory HiveService() {
    return instance;
  }

  //Собственно именованый конструктор который и нужен для создания экземпляра instance
  HiveService._internal() {
    //debugPrint('---- BoxService._internal done');
  }

//Набор действий при старте приложения
  Future<void> init() async {
    //debugPrint('---- HiveService.init start');

    //Проверяем существование адаптеров и если нету то создаём
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = await Hive.openBox<Group>('group_box');

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    //даже если явно не юзаем бокс то всё равно его открываем
    _taskBox = await Hive.openBox<Task>('tasks_box');

    //debugPrint('---- HiveService.init done');
  }

  //Набор действий при теоретическом закрытии приложения
  onClose() {
    //Т.к. документация не требует явного закрытия боксов и смысл в сжатии
    // в этом приложении отсутствует то данный код не имеет смысла
    //он даже вреден т.к. при перезапуске время на инициализацию боксов увеличится
    _groupBox.compact();
    _groupBox.close();
    _taskBox.compact();
    _taskBox.close();
    Hive.close();
  }
}
