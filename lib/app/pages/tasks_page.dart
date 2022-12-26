import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          TopBar(),
          const Expanded(
             child: Text('тут будет список задач'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //showGroupPage(context);
          Navigator.of(context).pushNamed('/group_page');
          //context.read<DataGlobal>().putDataS(AppLocalizations.of(context)!.helloWorld); //пишет в модель
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: const Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}
