import 'package:affairs/core/common_export.dart';
import 'package:intl/intl.dart';

class TopBar extends StatefulWidget  {
  TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with DefaultBackColor {
 static const _sFilterDefault='Фильтр не задан';
 late String _sFilter;

 @override
  void initState() {
    // TODO: implement initState
   _sFilter=_sFilterDefault;
    super.initState();
  }

 void onFilterPressed() {
   if (_sFilter==_sFilterDefault)
     {_sFilter = DateFormat("dd.MM.yyyy").format(DateTime.now());}
   else _sFilter=_sFilterDefault;

   setState(() {
   });
 }

 @override
  Widget build(BuildContext context) {
   IconData iconFilter = (_sFilter != _sFilterDefault) ? Icons.filter_alt : Icons.filter_alt_off;
    return Container(
      width: double.infinity,
      height: context.screenHeight() > context.screenWidth() ? 290 : 116,
      padding: EdgeInsets.only(
          top: context.screenHeight() > context.screenWidth() ? 15 : 2,
          left: 15,
          right: 15,
          bottom: context.screenHeight() > context.screenWidth() ? 30 : 0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset('assets/images/bg3.png').image,
            fit: BoxFit.contain,
            alignment: Alignment.centerRight),
        gradient: const LinearGradient(
          colors: [Colors.pink, Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(r, g, b, 0.3),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.dehaze),
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(r, g, b, 0.3),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Иконки с датами
                    ],
                  ),
                ),
                //Блок с округлёнными краями
                Chip(
                  label: Text(_sFilter,
                    style: medium,
                  ),
                  //avatar: Icon(Icons.filter_alt),
                  onDeleted: (){debugPrint('---- TopBar.Chip.onDeleted');
                  onFilterPressed(); },
                  deleteIcon: Icon(iconFilter),
                  backgroundColor: Color.fromRGBO(r, g, b, 0.2),
                ),
                const SizedBox(
                  width: 14,
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(r, g, b, 0.2),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                    tooltip: 'Показать график',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
