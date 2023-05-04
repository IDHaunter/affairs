import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeView();
}

class _ThemeView extends State<ThemeView> {
  Appearance? _appearance = themeHandler.appearance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false),
          ListTile(
            leading: const Icon(Icons.light_mode_outlined),
            title: Text(AppLocalizations.of(context)!.light, style: regular.copyWith(fontSize: titleSize)),
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
            title: Text(AppLocalizations.of(context)!.dark, style: regular.copyWith(fontSize: titleSize)),
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
            title: Text(AppLocalizations.of(context)!.system, style: regular.copyWith(fontSize: titleSize)),
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
