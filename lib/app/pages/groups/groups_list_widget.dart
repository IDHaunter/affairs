import 'package:affairs/app/pages/groups/groups_list_widget_viewmodel.dart';
import 'package:affairs/core/common_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int groupsCount = Provider.of<GroupsListWidgetViewModel>(context, listen: true).takeGroups.length;
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GroupsListRowWidget(indexInList: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: groupsCount);
  }
}

class GroupsListRowWidget extends StatelessWidget {
  final int indexInList;

  const GroupsListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<GroupsListWidgetViewModel>(context, listen: true).takeGroups[indexInList];

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              GroupPageArguments groupPageArguments = GroupPageArguments(groupIndex: indexInList, groupName: group.name);
              Navigator.of(context).pushNamed(MainNavigatorRouteNames.group, arguments: groupPageArguments);
            },
            backgroundColor: curITheme.majorShadow(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.drive_file_rename_outline,
            //label: 'Rename',
          ),
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              Provider.of<GroupsListWidgetViewModel>(context, listen: false).deleteGroupFromHive(indexInList);
              debugPrint('----delete: $indexInList');
            },
            backgroundColor: curITheme.accent(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.delete,
            //label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group.name, style: medium),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          debugPrint('--- groups_list_widget indexInList=$indexInList');
          Provider.of<GroupsListWidgetViewModel>(context, listen: false).showTasks(context, indexInList);
        },
      ),
    );
  }
}
