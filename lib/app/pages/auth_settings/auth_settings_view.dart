import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/service_locator.dart';

import '../../../core/auth/auth_service.dart';
import '../../../core/auth/auth_model.dart';

class AuthSettingsView extends StatefulWidget {
  const AuthSettingsView({super.key});

  @override
  State<AuthSettingsView> createState() => _SettingsView();
}

class _SettingsView extends State<AuthSettingsView> {
  AuthEnum? _authEnum = getIt<AuthService>().currentAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: [
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false, title: context.l()!.authentication, filterDefault: context.l()!.noFilter, dateDefault: context.l()!.noDate),
        Consumer<AuthModel>(builder: (context, model, child) {
          return Column(
            children: [
              ListTile(
                leading: const Icon(Icons.lock_open_outlined),
                title: Text(context.l()!.noAuth, style: regular.copyWith(fontSize: titleSize)),
                trailing: Transform.scale(
                  scale: 1.6,
                  child: Radio<AuthEnum>(
                    activeColor: curITheme.primary(),
                    value: AuthEnum.noAuth,
                    groupValue: _authEnum,
                    onChanged: (AuthEnum? value) {
                      //setState(() {
                        _authEnum = value;
                        model.currentAuth = AuthEnum.noAuth;
                        //languageHandler.updateLanguage(Language.russian, manually: true);
                        //Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.russian);
                      //});
                    },
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text(context.l()!.localAuth, style: regular.copyWith(fontSize: titleSize)),
                trailing: Transform.scale(
                  scale: 1.6,
                  child: Radio<AuthEnum>(
                    activeColor: curITheme.primary(),
                    value: AuthEnum.localAuth,
                    groupValue: _authEnum,
                    onChanged: (AuthEnum? value) {
                      //setState(() {
                        _authEnum = value;
                        model.currentAuth = AuthEnum.localAuth;
                        //languageHandler.updateLanguage(Language.english, manually: true);
                        //Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.english);
                      //});
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
