import 'package:affairs/core/common_export.dart';
import 'package:intl/intl.dart';

import '../pages/task/task_viewmodel.dart';

class TopBar extends StatefulWidget {
  final bool showFilter;
  final bool showCalendar;
  final bool showDatePicker;
  final bool? showDrawer;
  final DateTime? editDate;
  final String? title;
  final String filterDefault;
  final String dateDefault;

  const TopBar({
    Key? key,
    required this.showFilter,
    required this.showCalendar,
    required this.showDatePicker,
    this.showDrawer,
    this.editDate,
    this.title,
    required this.filterDefault,
    required this.dateDefault,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with DefaultBackColor {
  late final String _sFilterDefault;
  late final String _sDateDefault;
  late String _sFilter;
  late String _sDate;
  DateTime? _dateTime;
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _sFilterDefault = widget.filterDefault;
    _sDateDefault = widget.dateDefault;
    _sFilter = _sFilterDefault;
    if (widget.editDate == null) {
      _sDate = _sDateDefault;
    } else {
      _sDate = DateFormat("dd.MM.yyyy").format(widget.editDate!);
      _dateTime = widget.editDate;
      Provider.of<TaskViewModel>(context, listen: false).taskDateTime = widget.editDate!;
    }

    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Фильтр'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Задайте фильтр по имени'),
              controller: _controller,
            ),
            actions: [
              TextButton(onPressed: submit, child: const Text('ОК')),
            ],
          ));

  void submit() {
    Navigator.of(context).pop(_controller.text.isEmpty ? _sFilterDefault : _controller.text);
  }

  void onFilterPressed() async {
    _sFilter = await openDialog() ?? _sFilterDefault;
    setState(() {});
  }

  void onDatePickerPressed() {
    showDatePicker(
            context: context,
            initialDate: _dateTime ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      _dateTime = value;
      //работа с датой подразумевает наличие модели TaskPageModel т.к. её выбор возможен только на странице TaskPage
      if (_dateTime == null || DateUtils.dateOnly(_dateTime ?? DateTime.now()) == DateUtils.dateOnly(DateTime.now())) {
        _sDate = _sDateDefault;
        _dateTime = null;
        Provider.of<TaskViewModel>(context, listen: false).taskDateTime = null;
      } else {
        _sDate = DateFormat("dd.MM.yyyy").format(_dateTime!);
        Provider.of<TaskViewModel>(context, listen: false).taskDateTime = _dateTime!;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Icon iconFilter = (_sFilter != _sFilterDefault)
        ? Icon(color: curITheme.accent(), Icons.filter_alt)
        : Icon(color: curITheme.icon(), Icons.filter_alt_off);
    Icon iconDatePicker = (_sDate != _sDateDefault)
        ? Icon(color: curITheme.accent(), Icons.update)
        : Icon(color: curITheme.icon(), Icons.update_disabled);
    return Container(
      width: double.infinity,
      height: context.screenHeight() > context.screenWidth() ? 270 : 116,
      padding: EdgeInsets.only(
          top: context.screenHeight() > context.screenWidth() ? 15 : 2,
          left: context.screenHeight() > context.screenWidth() ? 15 : 0,
          right: 15,
          bottom: context.screenHeight() > context.screenWidth() ? 10 : 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset('assets/images/bg3.png').image, fit: BoxFit.contain, alignment: Alignment.centerRight),
        gradient: curITheme.accentGradientVertical(),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ((widget.showDrawer == null) || (widget.showDrawer == true))
                    ? CircleAvatar(
                        backgroundColor: Color.fromRGBO(r, g, b, 0.3),
                        child: IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.dehaze),
                          color: curITheme.icon(),
                        ),
                      )
                    : const Icon(Icons.perm_identity),
                (widget.title == null)
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                      )
                    : Row(
                        children: [
                          const SizedBox(
                            width: 8,
                            height: 16,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: context.screenWidth() - 130,
                            child: Text(
                              widget.title!,
                              style: bold,
                            ),
                          ),
                        ],
                      ),
                widget.showCalendar
                    ? CircleAvatar(
                        backgroundColor: Color.fromRGBO(r, g, b, 0.3),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.calendar_today_outlined),
                          color: curITheme.icon(),
                          tooltip: 'Календарь событий',
                        ),
                      )
                    : const SizedBox(width: 16, height: 16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.showDatePicker
                    ? Chip(
                        label: Text(
                          _sDate,
                          style: medium,
                        ),
                        //avatar: Icon(Icons.filter_alt),
                        onDeleted: () {
                          debugPrint('---- TopBar.ChipDatePicker.onDeleted');
                          onDatePickerPressed();
                        },
                        deleteIcon: iconDatePicker,
                        backgroundColor: Color.fromRGBO(r, g, b, 0.2),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            //Иконки с датами ближайших событий
                          ],
                        ),
                      ),
                //Блок с округлёнными краями - фильтр
                widget.showFilter
                    ? Chip(
                        label: Text(
                          _sFilter,
                          style: medium,
                        ),
                        //avatar: Icon(Icons.filter_alt),
                        onDeleted: () {
                          debugPrint('---- TopBar.ChipFilter.onDeleted');
                          onFilterPressed();
                        },
                        deleteIcon: iconFilter,
                        backgroundColor: Color.fromRGBO(r, g, b, 0.2),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
