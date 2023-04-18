import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/hive/group.dart';
import '../../../core/hive/box_handler.dart';

class GroupPageModel extends ChangeNotifier{
  int groupIndex;

  GroupPageModel({required this.groupIndex});

  var _groupName = '';
  String? errorText;

  set groupName (String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _groupName = value;
  }

  void addGroup(BuildContext context) async {
    //Если группа не задана или состоит из пробелов то показываем ошибку и выходим
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText='Название группы не указано';
      notifyListeners();
      return;}
    final box = boxHandler.groupBox;
    final group = Group(name: groupName);
    //add - не требует задания ключа, он автоинкрементиться в отличие от put
    //add вернёт нам ключ типа integer, но он нам тут не нужен
    //и поскольку он нам не нужен то выставляем инструкцию unawaited
    //unawaited(box.add(group));
    await box.add(group);
    //print('------- $groupName');
  }

  void editGroup(BuildContext context) async {
    //Если группа не задана или состоит из пробелов то показываем ошибку и выходим
    final groupName = _groupName.trim();
    if (groupName.isEmpty) {
      errorText='Название группы не указано';
      notifyListeners();
      return;}
    final box = boxHandler.groupBox;
    final int groupKey = box.keyAt(groupIndex);
    final Group? group2edit = box.get(groupKey);
    group2edit!.name = groupName;
    await box.put(groupKey, group2edit!);
    //await box.putAt(groupIndex, group2edit!); - Тоже работает
  }

}
