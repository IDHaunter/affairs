import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

import 'group_page_model.dart';

class GroupPage extends StatelessWidget {
  final int groupKeyFromNavigator;
  final String groupNameFromNavigator;
  const GroupPage({Key? key, required this.groupKeyFromNavigator, required this.groupNameFromNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical:
                    context.screenHeight() > context.screenWidth() ? 10 : 0,
                horizontal: 10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  //Text(groupKeyFromNavigator.toString()),
                  GroupNameWidget(initialValue: groupNameFromNavigator),
                ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (groupKeyFromNavigator==-1)
           { //Добавление
             Provider.of<GroupPageModel>(context, listen: false)
                 .addGroup(context);
           }
          else
            { //Изменение
              debugPrint('--------- before editGroup');
              Provider.of<GroupPageModel>(context, listen: false)
                  .editGroup(context);
              debugPrint('--------- after editGroup');
            }

          //возвращаемся на предыдущую страницу
          Provider.of<GroupPageModel>(context, listen: false).errorText ??
              Navigator.of(context).pop();
        },
        elevation: 5,
        child: const Icon(color: Colors.white, Icons.done),
      ),
    );
  }
}

class GroupNameWidget extends StatefulWidget {
  final String initialValue;
  const GroupNameWidget({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<GroupNameWidget> createState() => _GroupNameWidgetState();
}

class _GroupNameWidgetState extends State<GroupNameWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: regular.copyWith(fontSize: titleSize),
      autofocus: true,
      decoration: InputDecoration(
        //contentPadding: EdgeInsets.symmetric(horizontal: 25),
        //    border: OutlineInputBorder(),
        hintText: 'Введите имя группы',
        hintStyle: basic,
        errorText: Provider.of<GroupPageModel>(context, listen: true).errorText,
        errorStyle: regular.copyWith(fontSize: errorSize, color: curITheme.failure()) ,
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) =>
          Provider.of<GroupPageModel>(context, listen: false).groupName = value,
      //по нажатию на кнопку done
      onEditingComplete: () {
        Provider.of<GroupPageModel>(context, listen: false).addGroup(context);
        //возвращаемся на предыдущую страницу
        Provider.of<GroupPageModel>(context, listen: false).errorText ??
            Navigator.of(context).pop();
      },
      controller: _controller,
    );
  }
}
