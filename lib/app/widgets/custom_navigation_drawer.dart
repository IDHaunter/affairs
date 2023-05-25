import 'package:affairs/core/auth/auth_service.dart';
import 'package:affairs/core/common_export.dart';
import '../../core/auth/auth_model.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
      children: [
        SizedBox(
          height: 181,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: curITheme.accent(),
            ),
            child: Column(
              children: [
                InkWell(
                  child: CircleAvatar(
                    radius: 52,
                    backgroundImage: Image.asset('assets/images/goose_640.jpg').image,
                    //backgroundColor: Colors.pink,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, MainNavigatorRouteNames.groups);
                  },
                ),
                Text(context.l()!.welcomeBack, style: medium),
                Text('Anatoliy', style: bold.copyWith(fontSize: titleSize)),
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
                  title: Text(context.l()!.cryptoRates, style: bold),
                  leading: const Icon(Icons.currency_exchange),
                  onTap: () {
                    Navigator.pushNamed(context, MainNavigatorRouteNames.cryptoCoins);
                  },
                ),
              ),
              const Divider(),
              Card(
                child: ListTile(
                  title: Text(context.l()!.theme, style: bold),
                  subtitle: Text(nameFromAppearance(themeHandler.appearance, context), style: regular.copyWith(color: curITheme.textSecondary())),
                  leading: const Icon(Icons.format_paint),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.pushNamed(context, MainNavigatorRouteNames.theme);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text(context.l()!.language, style: bold),
                  subtitle: Text(context.l()!.nowLanguage, style: regular.copyWith(color: curITheme.textSecondary())),
                  leading: const Icon(Icons.language),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    Navigator.pushNamed(context, MainNavigatorRouteNames.language);
                  },
                ),
              ),
              Consumer<AuthModel>(builder: (context, model, child) {
                return Card(
                  child: ListTile(
                    title: Text(context.l()!.authentication, style: bold),
                    subtitle: Text(nameFromAuth(model.currentAuth, context), style: regular.copyWith(color: curITheme.textSecondary())),
                    leading: (model.currentAuth == AuthEnum.noAuth)
                        ? const Icon(Icons.lock_open_outlined)
                        : const Icon(Icons.lock_outline),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      Navigator.pushNamed(context, MainNavigatorRouteNames.auth);
                    },
                  ),
                );
              }),
              const Divider(),
              Card(
                child: ListTile(
                  title: Text(context.l()!.aboutApp, style: bold),
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
