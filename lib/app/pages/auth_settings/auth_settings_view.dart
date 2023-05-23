import 'package:affairs/app/pages/auth_settings/auth_settings_viewmodel.dart';
import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class AuthSettingsView extends StatefulWidget {
  const AuthSettingsView({super.key});

  @override
  State<AuthSettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<AuthSettingsView> {
  AuthEnum? _authEnum = AuthEnum.noAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: [
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false, title: 'Авторизация',),
        Consumer<AuthSettingsViewModel>(builder: (context, model, child) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.lock_open_outlined),
                title: Text('Без авторизации>', style: regular.copyWith(fontSize: titleSize)),
                trailing: Transform.scale(
                  scale: 1.6,
                  child: Radio<AuthEnum>(
                    activeColor: curITheme.primary(),
                    value: AuthEnum.noAuth,
                    groupValue: _authEnum,
                    onChanged: (AuthEnum? value) {
                      setState(() {
                        _authEnum = value;
                        //languageHandler.updateLanguage(Language.russian, manually: true);
                        //Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.russian);
                      });
                    },
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text('Системная авторизация', style: regular.copyWith(fontSize: titleSize)),
                trailing: Transform.scale(
                  scale: 1.6,
                  child: Radio<AuthEnum>(
                    activeColor: curITheme.primary(),
                    value: AuthEnum.localAuth,
                    groupValue: _authEnum,
                    onChanged: (AuthEnum? value) {
                      setState(() {
                        _authEnum = value;
                        //languageHandler.updateLanguage(Language.english, manually: true);
                        //Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.english);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        })
        ],
      ),
    );
  }
}
