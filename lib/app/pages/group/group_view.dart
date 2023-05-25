import 'package:affairs/app/widgets/top_bar.dart';
import 'package:affairs/app/widgets/custom_navigation_drawer.dart';
import 'package:affairs/core/common_export.dart';

import 'group_viewmodel.dart';

class GroupView extends StatelessWidget {
  final int groupKeyFromNavigator;
  final String groupNameFromNavigator;

  const GroupView({Key? key, required this.groupKeyFromNavigator, required this.groupNameFromNavigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TopBar(
              showCalendar: false,
              showFilter: false,
              showDatePicker: false,
              title: (groupNameFromNavigator == '') ? context.l()!.newGroup : context.l()!.editGroup,
              filterDefault: context.l()!.noFilter,
              dateDefault: context.l()!.noDate),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: context.screenHeight() > context.screenWidth() ? 10 : 0, horizontal: 10),
            child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
              //Text(groupKeyFromNavigator.toString()),
              GroupTextWidget(initialValue: groupNameFromNavigator),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (groupKeyFromNavigator == -1) {
            //Добавление
            Provider.of<GroupViewModel>(context, listen: false).addGroup(context);
          } else {
            //Изменение
            debugPrint('--------- before editGroup');
            Provider.of<GroupViewModel>(context, listen: false).editGroup(context);
            debugPrint('--------- after editGroup');
          }

          //возвращаемся на предыдущую страницу
          Provider.of<GroupViewModel>(context, listen: false).errorText ?? Navigator.of(context).pop();
        },
        elevation: 5,
        child: const Icon(color: Colors.white, Icons.done),
      ),
    );
  }
}

class GroupTextWidget extends StatefulWidget {
  final String initialValue;

  const GroupTextWidget({Key? key, required this.initialValue}) : super(key: key);

  @override
  State<GroupTextWidget> createState() => _GroupTextWidgetState();
}

class _GroupTextWidgetState extends State<GroupTextWidget> {
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
        errorText: Provider.of<GroupViewModel>(context, listen: true).errorText,
        errorStyle: regular.copyWith(fontSize: errorSize, color: curITheme.failure()),
        //helperText: 'Имя группы',
      ),
      //по изменению
      onChanged: (value) => Provider.of<GroupViewModel>(context, listen: false).groupName = value,
      //по нажатию на кнопку done
      onEditingComplete: () {
        Provider.of<GroupViewModel>(context, listen: false).addGroup(context);
        //возвращаемся на предыдущую страницу
        Provider.of<GroupViewModel>(context, listen: false).errorText ?? Navigator.of(context).pop();
      },
      controller: _controller,
    );
  }
}
