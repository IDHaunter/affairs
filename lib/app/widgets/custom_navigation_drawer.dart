import 'package:affairs/core/auth/auth_service.dart';
import 'package:affairs/core/common_export.dart';

import '../../core/auth/auth_model.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nameFromAppearance(Appearance appearance) {
      switch (appearance) {
        case Appearance.light:
          return '${context.l()!.nowItIs} ${context.l()!.light.toLowerCase()}';
        case Appearance.dark:
          return '${context.l()!.nowItIs} ${context.l()!.dark.toLowerCase()}';
        default:
          return '${context.l()!.nowItIs} ${context.l()!.system.toLowerCase()}';
      }
    }

    String nameFromAuth(AuthEnum authEnum) {
      switch (authEnum) {
        case AuthEnum.noAuth:
          return context.l()!.noAuth.toLowerCase();
        case AuthEnum.localAuth:
          return context.l()!.localAuth.toLowerCase();
        default:
          return context.l()!.noAuth.toLowerCase();
      }
    }

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
                  title: Text('Crypto rates', style: bold),
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
                  subtitle: Text(nameFromAppearance(themeHandler.appearance), style: regular),
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
                  subtitle: Text(context.l()!.nowLanguage, style: regular),
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
                    subtitle: Text(nameFromAuth(model.currentAuth), style: regular),
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
