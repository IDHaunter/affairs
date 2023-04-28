import 'package:flutter/widgets.dart';

class GlobalViewModel with ChangeNotifier {
  String dataS='Top level string';

  get takeDataS => dataS;

  void putDataS(String newString) {
  dataS = newString;

  //Изменили данные и добавили оповещалку, которая сообщит подписчикам о том
  // что им нужно перерисоваться
  notifyListeners();
  }
}