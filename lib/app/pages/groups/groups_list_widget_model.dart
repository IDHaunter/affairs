import 'dart:async';

import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/entity/task.dart';

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
    final int groupKey = await box.keyAt(groupIndex); // as int - т.к. мы добавляли через add то тип будет integer
    if (!mounted) return;
    unawaited(Navigator.of(context).pushNamed(MainNavigatorRouteNames.tasks, arguments: groupKey)) ;
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
    //перед удалением группы удаляем её таски
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  void _setup() async {
    //Проверяем существование адаптера и если нету то создаём
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('group_box');

    //Проверяем существование адаптера по такскам и если нету то создаём
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskAdapter());
    }
    await Hive.openBox<Task>('task_box');

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