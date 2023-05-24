import 'dart:async';

import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/data/hive/group.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/data/hive/hive_service.dart';
import '../../../core/service_locator.dart';

class GroupsListWidgetViewModel extends ChangeNotifier {
  var _groups = <Group>[];

  //toList() - вернёт другой список, чтобы снаружи не сделали add (это защита)
  List<Group> get takeGroups => _groups.toList();

  void showTasks(BuildContext context, int groupIndex, [bool mounted = true]) async {
    debugPrint('------- showTasks getIt<HiveHandler>');
    final box = getIt<HiveService>().groupBox;
    final int groupKey = await box.keyAt(groupIndex); // as int - т.к. мы добавляли через add то тип будет integer
    if (!mounted) return;
    unawaited(Navigator.of(context).pushNamed(MainNavigatorRouteNames.tasks, arguments: groupKey)) ;
  }

  void _readGroupsFromHive(Box<Group> box) {
    _groups = box.values.toList();
    notifyListeners();
  }

  void deleteGroupFromHive(int groupIndex) async {
    final box = getIt<HiveService>().groupBox;
    //перед удалением группы удаляем её таски
    await box.getAt(groupIndex)?.tasks?.deleteAllFromHive();
    await box.deleteAt(groupIndex);
  }

  void _setup() async {
    debugPrint('------- _setup getIt<HiveHandler>');
    final box = getIt<HiveService>().groupBox;
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