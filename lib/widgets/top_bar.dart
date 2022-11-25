import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: DecorationImage(image: Image.asset('assets/images/bg2.png').image, fit: BoxFit.contain),
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.transparent],
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
                  backgroundColor: Color.fromRGBO(255, 0, 0, 0.3),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.dehaze),
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 0, 0, 0.3),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_today),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Chip(label: Text('02.06.2020', style: TextStyle(color: Colors.white),),
                backgroundColor: Color.fromRGBO(255, 0, 0, 0.5),),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 0, 0, 0.5),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.insert_chart),
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
