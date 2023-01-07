import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/entity/group.dart';
import 'package:hive/hive.dart';

import '../../../core/entity/box_handler.dart';

class GroupPageModel {
  var groupName = '';
  void saveGroup(BuildContext context) async {
    //Если группа не задана то выходим
    if (groupName.isEmpty) return;
    final box = boxHandler.groupBox;
    final group = Group(name: groupName);
    //add - не требует задания ключа, он автоинкрементиться в отличие от put
    //add вернёт нам ключ типа integer, но он нам тут не нужен
    //и поскольку он нам не нужен то выставляем инструкцию unawaited
    //unawaited(box.add(group));
    await box.add(group);
    //print('------- $groupName');
  }
}
