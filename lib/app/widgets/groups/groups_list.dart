import 'package:affairs/core/common_export.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({Key? key}) : super(key: key);

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const GroupListRowWidget();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: 10);

  }
}

class GroupListRowWidget extends StatelessWidget {
  const GroupListRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('The End of the Fucking World', style: medium ),
      trailing: const Icon(Icons.more_vert),
    );
  }
}
