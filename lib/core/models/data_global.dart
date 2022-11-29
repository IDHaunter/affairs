import 'package:flutter/widgets.dart';

class DataGlobal with ChangeNotifier {
  String dataS='Top level string';

  get getDataS => dataS;

  void changeString(String newString) {
  dataS = newString;

  //Изменили данные и добавили оповещалку, которая сообщит подписчикам о том
  // что им нужно перерисоваться
  notifyListeners();
  }
}