import 'package:hive/hive.dart';

import '../../../core/common_export.dart';
import '../../../core/entity/group.dart';

class TasksListWidgetModel extends ChangeNotifier {
int groupKey;
late final Future<Box<Group>> _groupBox;
Group? _group;
Group? get takeGroup => _group;

TasksListWidgetModel({required this.groupKey}){
  //print('--- TasksListWidgetModel = $groupKey ');
  _setup();
}

void _setup() {
  //Проверяем существование адаптера и если нету то создаём
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(GroupAdapter());
  }
  _groupBox = Hive.openBox<Group>('group_box');
  _loadGroup();
}

//Получение группы по ключу
void _loadGroup() async {
  final box = await _groupBox;
  _group = box.get(groupKey);
  notifyListeners();
}

}