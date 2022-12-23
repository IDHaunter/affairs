import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

import 'group_page_model.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: context.screenHeight() > context.screenWidth() ? 10 : 0, horizontal: 10),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: const [
              // Text(
              //   'Новая группа',
              //   style: regular.copyWith(fontSize: titleSize),
              // ),
              GroupNameWidget(),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => GroupPageModelProvider.read(context)?.model.saveGroup(context),
        elevation: 5, child: const Icon(color: Colors.white, Icons.done), ) ,
    );
  }
}

class GroupNameWidget extends StatefulWidget {
  const GroupNameWidget({Key? key}) : super(key: key);

  @override
  State<GroupNameWidget> createState() => _GroupNameWidgetState();
}

class _GroupNameWidgetState extends State<GroupNameWidget> {
  final _model = GroupPageModel();
  @override
  Widget build(BuildContext context) {
    return GroupPageModelProvider(model: _model,child: const _GroupNameWidget(),);
  }
}


class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('build _GroupNameWidget');
    final model = GroupPageModelProvider.read(context)?.model;
    return TextField(
      textAlign: TextAlign.center,
      style: regular.copyWith(fontSize: titleSize),
      autofocus: true,
      decoration: InputDecoration(
        //contentPadding: EdgeInsets.symmetric(horizontal: 25),
        //    border: OutlineInputBorder(),
        hintText: 'Введите имя группы',
        hintStyle: basic,
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) => model?.groupName = value,
      //по нажатию на кнопку done
      onEditingComplete: () => {model?.saveGroup(context)},
    );
  }
}
