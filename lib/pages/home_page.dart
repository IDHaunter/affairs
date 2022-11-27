import 'package:affairs/models/data_global.dart';
import 'package:affairs/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Column(
        children: [TopBar(),
          //Text(context.watch<String>()) - для обычного провайдера
          Text(context.watch<DataGlobal>().getDataS),
          SizedBox(height: 20,),
          SomeDataS(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<DataGlobal>().changeString('Button + Pressed');
        },
        elevation: 5,
        tooltip: 'Добавить новую задачу',
        child: Icon(color: Colors.white, Icons.add),
      ),
    );
  }
}

class SomeDataS extends StatelessWidget {
  const SomeDataS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newData) => context.read<DataGlobal>().changeString(newData)
    );
  }
}
