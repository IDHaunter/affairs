import 'package:affairs/app/widgets/groups/groups_list_widget_model.dart';
import 'package:affairs/core/common_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({Key? key}) : super(key: key);

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    final int groupsCount = Provider.of<GroupsListWidgetModel>(context, listen: true)
        .takeGroups.length ?? 0;
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GroupListRowWidget(indexInList: index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: groupsCount);

  }
}

class GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const GroupListRowWidget({Key? key, required this.indexInList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<GroupsListWidgetModel>(context, listen: false).takeGroups[indexInList];

    return Slidable(
      // Specify a key if the Slidable is dismissible.
      //key: const ValueKey(0),
      // The start action pane is the one at the left or the top side.
//      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
//        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        //dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
//        children:  [

          // SlidableAction(
          //   // An action can be bigger than the others.
          //   flex: 2,
          //   onPressed:(context){},
          //   backgroundColor: Color(0xFF7BC043),
          //   foregroundColor: Colors.white,
          //   icon: Icons.archive,
          //   label: 'Archive',
          // ),
          // SlidableAction(
          //   onPressed: (context){},
          //   backgroundColor: Color(0xFF0392CF),
          //   foregroundColor: Colors.white,
          //   icon: Icons.save,
          //   label: 'Save',
          // ),

//        ],
//      ),

      //The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context){},
            backgroundColor: curITheme.majorShadow(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.drive_file_rename_outline,
            //label: 'Rename',
          ),
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(

            onPressed: (context){
              Provider.of<GroupsListWidgetModel>(context, listen: false).deleteGroupFromHive(indexInList);
              print('----delete: $indexInList');
            },
            backgroundColor: curITheme.accent(),
            foregroundColor: curITheme.buttonText(),
            icon: Icons.delete,
            //label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group.name, style: medium ),
        trailing: const Icon(Icons.chevron_right),
        onTap: (){},
      ),
    );
  }
}
