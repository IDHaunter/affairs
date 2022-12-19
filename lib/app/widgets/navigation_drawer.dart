import 'package:affairs/core/common_export.dart';

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
                subtitle: Text(Provider.of<ThemeModel>(context, listen: true ).sDrawer),
                leading: Icon(Icons.format_paint),
                trailing: Icon(Icons.more_vert),
                onTap: () {
                  Navigator.pushNamed(context, '/theme_page');
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Language'),
                subtitle: Text("Now it's English"),
                leading: Icon(Icons.language),
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