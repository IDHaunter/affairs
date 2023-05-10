import 'dart:convert';

import '../../common_export.dart';

class HttpBaseViewModel extends ChangeNotifier {
  //любой http запрос оканчивается либо получением данных или ошибкой
  //Базовая модель следит за процессом получения данных (isLoading) и процессом расшифровки ошибок (sError),
  //оба процесса уведомляют подписчиков об изменении

  //Для отображения ошибки на разных языках используем пакет локализации
  AppLocalizations? l;

  //получение данных -----------------------------------------------------------------------------------------
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    //notifyListeners();
  }

  //обработка ошибок -----------------------------------------------------------------------------------------
  //У ошибки всегда есть текст для отображения пользователю
  // и потенциально может быть список ошибок в ответе от API но тут уже зависит от реализации на стороне сервера
  String? _sError;
  String? get sError => _sError;

  set sError(String? value) {
    _sError = value;
    //notifyListeners();
  }

  void clearError() {
    sError = null;
  }

  void handleApiError(dynamic err) {
    if (err is DioError) {
      switch (err.type) {
        case DioErrorType.connectionError:
          //error = l?.error_no_internet ?? "";
          sError = 'error_no_internet';
          break;
        case DioErrorType.connectionTimeout:
          //error = l?.network_error_timeout ?? "";
          sError = 'network_error_timeout';
          break;
        case DioErrorType.badResponse: //response
          { //Тут могла бы быть реализация разбора ответа от сервера и его списка ошибок
            sError = 'badResponse';
          }
          break;
        default:
          if (err.response?.statusCode == 500) {
            //error = l?.network_error_internal_server_error ?? "";
            sError = 'network_error_internal_server_error';
            break;
          } else {
            sError = err.message;
            break;
          }
      }
    } else {
      if (err.response?.statusCode == 500) {
        //error = l?.network_error_internal_server_error ?? "";
        sError = 'network_error_internal_server_error';
      } else {
        sError = err.toString();
      }
    }
  }

}
