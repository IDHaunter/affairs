import 'package:affairs/core/common_export.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String nameFromAppearance(Appearance appearance) {
      switch (appearance) {
        case Appearance.light:
          return '${AppLocalizations.of(context)!.nowItIs} ${AppLocalizations.of(context)!.light.toLowerCase()}' ;
        case Appearance.dark:
          return '${AppLocalizations.of(context)!.nowItIs} ${AppLocalizations.of(context)!.dark.toLowerCase()}';
        default:
          return '${AppLocalizations.of(context)!.nowItIs} ${AppLocalizations.of(context)!.system.toLowerCase()}';
      }
    }

    return Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 180,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: curITheme.accent(),
                ),
                child: Column(
                  children: [ InkWell(
                    child: CircleAvatar(

                      radius: 52,
                      backgroundImage: Image.asset('assets/images/goose_640.jpg').image,
                      //backgroundColor: Colors.pink,
                    ),
                    onTap: () {Navigator.pushNamed(context, '/');},
                  ),
                    Text(AppLocalizations.of(context)!.welcomeBack ),
                    const Text('Anatoliy', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
            Container(
             padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [

                  Card(
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.theme),
                      //subtitle: Text(Provider.of<ThemeModel>(context, listen: true ).sDrawer),
                      subtitle: Text(nameFromAppearance(themeHandler.appearance)),
                      leading: const Icon(Icons.format_paint),
                      trailing: const Icon(Icons.more_vert),
                      onTap: () {
                        Navigator.pushNamed(context, '/theme_page');
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.language),
                      subtitle: Text(AppLocalizations.of(context)!.nowLanguage),
                      leading: const Icon(Icons.language),
                      trailing: const Icon(Icons.more_vert),
                      onTap: () {
                        Navigator.pushNamed(context, '/language_page');
                      },
                    ),
                  ),
                  const Divider(),
                  Card(
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.aboutApp),
                      leading: const Icon(Icons.info_outline),
                      onTap: () {},
                    ),
                  ),

                ],
              ),
            ),

          ],
        ));
  }
}