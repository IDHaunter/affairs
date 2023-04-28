import 'dart:async';

import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/hive/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/hive/box_handler.dart';

class GroupsListWidgetViewModel extends ChangeNotifier {
  var _groups = <Group>[];

  //toList() - вернёт другой список, чтобы снаружи не сделали add (это защита)
  List<Group> get takeGroups => _groups.toList();

  void showTasks(BuildContext context, int groupIndex, [bool mounted = true]) async {
    final box = boxHandler.groupBox;
    final int groupKey = await box.keyAt(groupIndex); // as int - т.к. мы добавляли через add то тип будет integer
    if (!mounted) return;
    unawaited(Navigator.of(context).pushNamed(MainNavigatorRouteNames.tasks, arguments: groupKey)) ;
  }

  void _readGroupsFromHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void deleteGroupFromHive(int groupIndex) async {
    final box = boxHandler.groupBox;
    //перед удалением группы удаляем её таски
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  void _setup() async {
    final box = boxHandler.groupBox;
    _readGroupsFromHive(box);

    //дополнительно подпишемся на этот box
    box.listenable().addListener(() {
      _readGroupsFromHive(box);
    });
  }

  //В конструкторе сетапимся
  GroupsListWidgetViewModel() {
    _setup();
  }

}