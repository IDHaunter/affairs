import 'package:hive/hive.dart';

import '../../../core/common_export.dart';
import '../../../core/entity/group.dart';

class TasksListWidgetModel extends ChangeNotifier {
int groupKey;
late final Future<Box<Group>> _groupBox;
Group? _group;
Group? get takeGroup => _group;

TasksListWidgetModel({required this.groupKey}){
  print('--- TasksListWidgetModel = $groupKey ');
  print('--- TasksListWidgetModel begin setup');
  _setup();
  print('--- TasksListWidgetModel end setup');
}

void _setup() {
  //Проверяем существование адаптера и если нету то создаём
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(GroupAdapter());
  }
  _groupBox = Hive.openBox<Group>('group_box');
  print('--- _setup = $_groupBox ');
  _loadGroup();
}

//Получение группы по ключу
void _loadGroup() async {
  final box = await _groupBox;
  print('--- _loadGroup groupKey= $groupKey ');
  _group = box.get(groupKey);
  print('--- _group.name = ${_group?.name} ');
  notifyListeners();
}

}