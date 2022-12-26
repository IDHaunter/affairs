import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical:
                context.screenHeight() > context.screenWidth() ? 10 : 0,
                horizontal: 10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  GroupNameWidget(),
                ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Provider.of<GroupPageModel>(context, listen: false).saveGroup(context);
          //возвращаемся на предыдущую страницу
          Navigator.of(context).pop();
        },
        elevation: 5,
        child: const Icon(color: Colors.white, Icons.done),
      ),
    );
  }
}

class GroupNameWidget extends StatelessWidget {
  const GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: regular.copyWith(fontSize: titleSize),
      autofocus: true,
      decoration: InputDecoration(
        //contentPadding: EdgeInsets.symmetric(horizontal: 25),
        //    border: OutlineInputBorder(),
        hintText: 'Введите новую задачу',
        hintStyle: basic,
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) => {},
      //Provider.of<GroupPageModel>(context, listen: false).groupName = value,
      //по нажатию на кнопку done
      onEditingComplete: () {
        //Provider.of<GroupPageModel>(context, listen: false).saveGroup(context);
        //возвращаемся на предыдущую страницу
        Navigator.of(context).pop();
      },
    );
  }
}