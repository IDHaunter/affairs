import 'package:affairs/app/pages/task/task_page_model.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class TaskPage extends StatelessWidget {
  final int groupKeyFromNavigator;
   const TaskPage({Key? key, required this.groupKeyFromNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('---- TaskPage.build groupKeyFromNavigator=$groupKeyFromNavigator');
    //final currentGroupKey = ModalRoute.of(context)!.settings.arguments as int; - при работе через свой навигатор (MainNavigator) будет = null !!!
    final currentGroupKey=groupKeyFromNavigator;

    return ChangeNotifierProvider<TaskPageModel>(
        create: (context) => TaskPageModel(groupKey: currentGroupKey),
        lazy: false,
        child: TaskPageWidget());
  }
}

class TaskTextWidget extends StatelessWidget {
  const TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      //textAlign: TextAlign.center,
      style: regular.copyWith(fontSize: titleSize),
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        //contentPadding: EdgeInsets.symmetric(horizontal: 25),
        //border: OutlineInputBorder(),
        border: InputBorder.none,
        hintText: 'Текст задачи',
        //hintStyle: basic,
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) =>
          Provider.of<TaskPageModel>(context, listen: false).taskText = value,
      //по нажатию на кнопку done
      onEditingComplete: () {
        Provider.of<TaskPageModel>(context, listen: false).saveTask(context);
        //возвращаемся на предыдущую страницу
        Navigator.of(context).pop();
      },
    );
  }
}

class TaskPageWidget extends StatelessWidget {
  const TaskPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('---- TaskPageWidget.build');
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                         vertical:
                             context.screenHeight() > context.screenWidth() ? 10 : 0,
                        horizontal: 10),
                child: TaskTextWidget(),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<TaskPageModel>(context, listen: false).saveTask(context);
          if (Provider.of<TaskPageModel>(context, listen: false).errorText != null)
          {print('---- TaskPageWidget.ScaffoldMessenger');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No way!')));}
          {//возвращаемся на предыдущую страницу
            print('---- TaskPageWidget.Navigator.of(context).pop');
            Navigator.of(context).pop();}
        },
        elevation: 5,
        child: const Icon(color: Colors.white, Icons.done),
      ),
    );
  }
}
