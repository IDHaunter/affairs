import 'package:affairs/core/common_export.dart';
import 'package:intl/intl.dart';

//миксин тут для эксперимента
mixin DefaultColor {
  final int r=230;
  final int g=0;
  final int b=150;
}

class TopBar extends StatelessWidget with DefaultColor {
  TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: context.screenHeight() > context.screenWidth() ? 300 : 140,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: context.screenHeight() > context.screenWidth() ? 15 : 7),
      decoration: BoxDecoration(
        image: DecorationImage(image: Image.asset('assets/images/bg3.png').image, fit: BoxFit.contain, alignment: Alignment.centerRight),
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
                  backgroundColor: Color.fromRGBO( r, g, b, 0.3),
                  child: IconButton(
                    onPressed: () {Scaffold.of(context).openDrawer();},
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
                Chip(label: Text( DateFormat("dd.MM.yyyy").format(DateTime.now()) , style: medium, ),
                backgroundColor: Color.fromRGBO(r, g, b, 0.2),),
                const SizedBox(width: 14,),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(r, g, b, 0.2),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.insert_chart),
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
