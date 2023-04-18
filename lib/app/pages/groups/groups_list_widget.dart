import 'package:affairs/app/pages/groups/groups_list_widget_model.dart';
import 'package:affairs/core/common_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsListWidget extends StatelessWidget {
  const GroupsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int groupsCount = Provider.of<GroupsListWidgetModel>(context, listen: true).takeGroups.length;
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
    final group = Provider.of<GroupsListWidgetModel>(context, listen: true).takeGroups[indexInList];

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.of(context).pushNamed(MainNavigatorRouteNames.group, arguments: indexInList);
            },
            backgroundColor: curITheme.majorShadow(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.drive_file_rename_outline,
            //label: 'Rename',
          ),
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              Provider.of<GroupsListWidgetModel>(context, listen: false).deleteGroupFromHive(indexInList);
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
          Provider.of<GroupsListWidgetModel>(context, listen: false).showTasks(context, indexInList);
        },
      ),
    );
  }
}
