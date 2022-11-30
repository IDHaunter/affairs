import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/core/common_export.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          TopBar(),
          //Text(context.watch<String>()) - для обычного провайдера
          Text(context.watch<DataGlobal>().getDataS),
          SizedBox(
            height: 20,
          ),
          SomeDataS(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DataGlobal>().changeString(AppLocalizations.of(context)!.helloWorld);
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          height: 180,
          child: DrawerHeader(

            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Column(
              children: [ CircleAvatar(
                radius: 52,
                backgroundImage: Image.asset('assets/images/goose_640.jpg').image,
                //backgroundColor: Colors.pink,
              ),
                Text('Welcome back'),
                Text('Anatoliy', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Theme'),
            subtitle: Text('Now it is Dark'),
            leading: Icon(Icons.language),
            trailing: Icon(Icons.more_vert),
            onTap: () {},
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Language'),
            subtitle: Text("Now it's English"),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.more_vert),
            onTap: () {},
          ),
        ),
        Divider(),
        Card(
          child: ListTile(
            title: Text('About application'),
            leading: Icon(Icons.info_outline),
            onTap: () {},
          ),
        ),
      ],
    ));
  }
}

class SomeDataS extends StatelessWidget {
  const SomeDataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (newData) => context.read<DataGlobal>().changeString(newData));
  }
}
