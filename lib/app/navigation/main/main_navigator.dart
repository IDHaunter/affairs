import '../../../core/common_export.dart';
import '../../pages/group/group_page.dart';
import '../../pages/group/group_page_model.dart';
import '../../pages/groups/groups_page.dart';
import '../../pages/language/language_page.dart';
import '../../pages/task/task_page.dart';
import '../../pages/tasks/tasks_page.dart';
import '../../pages/theme/theme_page.dart';

//Мы создали этот абстрактный класс для того чтобы нигде в коде не писать имена страниц т.к. в них можно ошибиться
//согласно принципу - S.S.O.T. - single source of truth
abstract class MainNavigatorRouteNames {
  //стартовая страница всегда должна начинаться с "/", иначе (если например "/aaa") компилятор будет давать возможность делать с этой страницы
  //переход назад до "/", или нужно называть страницы вообще без символов "/" чтобы не использовать принцип deep link
  static const groups = '/'; // GroupsPage()
  static const group = '/group_page'; // Provider<GroupPageModel>(create: (context) => GroupPageModel(), child: GroupPage()),
  static const theme = '/theme_page'; // ThemePage()
  static const language ='/language_page'; // LanguagePage(),
  static const tasks = '/tasks_page'; // TasksPage(),
  static const task = '/tasks_page/task_page'; // TaskPage(),
}

class MainNavigator {
 final initialRoute = MainNavigatorRouteNames.groups;
 //routes проверяется до вызова onGenerateRoute
 final routes = <String, Widget Function(BuildContext)>{
   //1. тут нельзя задавать const т.к. при смене тем оформления будет глюк
   //2. если страница №2 вызывается со страницы №1 то контекст первой
   //не наследуется во второй (видно в DevTools и важно для моделей данных)
   MainNavigatorRouteNames.groups: (context) => GroupsPage(),
   MainNavigatorRouteNames.group: (context) => ChangeNotifierProvider<GroupPageModel>(
       create: (context) => GroupPageModel(),
       child: GroupPage()),
   MainNavigatorRouteNames.theme: (context) => ThemePage(),
   MainNavigatorRouteNames.language: (context) => LanguagePage(),
   MainNavigatorRouteNames.tasks: (context) => TasksPage(),
   //MainNavigatorRouteNames.task: (context) => TaskPage(),
 };

//Эта функция позволяет в зависимости от имени и аргумента возвращать разные экраны
  //кроме передачи параметров используется часто для кастомной анимации смены разных экранов
  Route<Object> onGenerateRoute(RouteSettings settings) {
    //RouteSettings содержит собственно имя "name" и аргументы "arguments"
    //print('---- onGenerateRoute ${settings.name} ::: ${settings.arguments} ');
    switch (settings.name) {
      case MainNavigatorRouteNames.task:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(builder: (context) => TaskPage(groupKeyFromNavigator: groupKey)
        );
      default: const widget = Text('Requested page not found!');
               return MaterialPageRoute(builder: (context) => widget);
    }
  }

}

