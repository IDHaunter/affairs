import 'dart:async';

import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroupsListWidgetModel extends ChangeNotifier {
  var _groups = <Group>[];

  //toList() - вернёт другой список, чтобы снаружи не сделали add (это защита)
  List<Group> get takeGroups => _groups.toList();

  void showTasks(BuildContext context, int groupIndex, [bool mounted = true]) async {
    //Проверяем существование адаптера и если нету то создаём
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');
    final groupKey = box.keyAt(groupIndex); // as int - т.к. мы добавляли через add то тип будет integer
    if (!mounted) return;
    unawaited(Navigator.of(context).pushNamed('/tasks_page', arguments: groupKey)) ;
  }

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