import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePage();
}

class _ThemePage extends State<ThemePage> {
  Appearance? _appearance = themeHandler.appearance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(),
          ListTile(
            leading: Icon(Icons.light_mode_outlined),
            title: Text(AppLocalizations.of(context)!.light),
            trailing: Transform.scale(
              scale: 1.6,
              child: Radio<Appearance>(
                activeColor: curITheme.primary(),
                value: Appearance.light,
                groupValue: _appearance,
                onChanged: (Appearance? value) {
                  // setState закоментирован т.к. Provider сам вызовет setState после изменений
                  // setState(() {
                  _appearance = value;
                  themeHandler.updateTheme(Appearance.light);
                  Provider.of<ThemeModel>(context,listen: false).changeCurrentTheme(Appearance.light);
                 //  });

                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: Text(AppLocalizations.of(context)!.dark),
            trailing: Transform.scale(
              scale: 1.6,
              child: Radio<Appearance>(
                activeColor: curITheme.primary(),
                value: Appearance.dark,
                groupValue: _appearance,
                onChanged: (Appearance? value) {
                  // setState(() {
                  _appearance = value;
                  themeHandler.updateTheme(Appearance.dark);
                  Provider.of<ThemeModel>(context,listen: false).changeCurrentTheme(Appearance.dark);
                  // });

                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.format_paint_outlined),
            title: Text(AppLocalizations.of(context)!.system),
            trailing: Transform.scale(
              scale: 1.6,
              child: Radio<Appearance>(
                activeColor: curITheme.primary(),
                value: Appearance.system,
                groupValue: _appearance,
                onChanged: (Appearance? value) {
                  // setState(() {
                  _appearance = value;
                  themeHandler.updateTheme(Appearance.system);
                  Provider.of<ThemeModel>(context,listen: false).changeCurrentTheme(Appearance.system);
                  // });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
