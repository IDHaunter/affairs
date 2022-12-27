import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePage();
}

class _LanguagePage extends State<LanguagePage> {
  Language? _language = languageHandler.language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('Русский', style: regular.copyWith(fontSize: titleSize)),
            trailing: Transform.scale(
              scale: 1.6,
              child: Radio<Language>(
                activeColor: curITheme.primary(),
                value: Language.russian,
                groupValue: _language,
                onChanged: (Language? value) {
                   setState(() {
                     _language = value;
                     languageHandler.updateLanguage(Language.russian, manually: true);
                     Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.russian);
                   });
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('English', style: regular.copyWith(fontSize: titleSize)),
            trailing: Transform.scale(
              scale: 1.6,
              child: Radio<Language>(
                activeColor: curITheme.primary(),
                value: Language.english,
                groupValue: _language,
                onChanged: (Language? value) {
                   setState(() {
                     _language = value;
                     languageHandler.updateLanguage(Language.english, manually: true);
                     Provider.of<LanguageModel>(context,listen: false).changeCurrentLocale(Language.english);
                   });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
