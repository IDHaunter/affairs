//----------------------------------------------------------------------------------------------------
//Конструируем модель типа Locale для провайдера исходя из данных носителя
import '../core/common_export.dart';

class LanguageModel extends ChangeNotifier {
  Locale currentLocale = languageHandler.getLocale();

  //Обновление текущего языка
  changeCurrentLocale(Language language) {
    currentLocale = languageHandler.getLocale();
    //Собственно уведомляем подписаных
    notifyListeners();
  }

}