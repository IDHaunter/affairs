import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroupsListWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  //toList() - вернёт другой список, чтобы снаружи не сделали add (это защита)
  List<Group> get takeGroups => _groups.toList();

  void _readGroupsFromHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void deleteGroupFromHive(int groupIndex) async {
    //Проверяем существование адаптера и если нету то создаём
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    await box.deleteAt(groupIndex);
  }

  void _setup() async {
    //Проверяем существование адаптера и если нету то создаём
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    _readGroupsFromHive(box);

    //дополнительно подпишемся на этот box
    box.listenable().addListener(() {
      _readGroupsFromHive(box);
    });
  }

  //В конструкторе сетапимся
  GroupsListWidgetModel() {
    _setup();
  }

}