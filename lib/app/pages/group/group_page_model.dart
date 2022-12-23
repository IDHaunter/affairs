import 'package:affairs/core/common_export.dart';

class GroupPageModel {
  var groupName = '';
  void saveGroup(BuildContext context) {
    print('------- $groupName');
  }

}

class GroupPageModelProvider extends InheritedWidget {
  final GroupPageModel model;
  const GroupPageModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static GroupPageModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GroupPageModelProvider>();
  }

  static GroupPageModelProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<GroupPageModelProvider>()?.widget;
    return widget is GroupPageModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(GroupPageModelProvider oldWidget) {
    return true;
  }
}
