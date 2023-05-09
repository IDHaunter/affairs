import 'dart:convert';

import '../../common_export.dart';

class ApiError {
  final String key;
  final String message;

  ApiError({required this.key, required this.message});
}

class HttpBaseViewModel extends ChangeNotifier {
  //любой http запрос оканчивается либо получением данных или ошибкой
  //Базовая модель следит за процессом получения данных (isLoading) и процессом расшифровки ошибок (sError),
  //оба процесса уведомляют подписчиков об изменении

  //Для отображения ошибки на разных языках используем пакет локализации
  AppLocalizations? l;

  //получение данных -----------------------------------------------------------------------------------------
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //обработка ошибок -----------------------------------------------------------------------------------------
  String? _sError;

  String? get sError => _sError;

  set sError(String? value) {
    _sError = value;
    notifyListeners();
  }

  void clearError() {
    sError = null;
  }

  List<ApiError> handleApiError(dynamic err) {
    if (err is DioError) {
      switch (err.type) {
        case DioErrorType.connectionError:
          //error = l?.error_no_internet ?? "";
          sError = 'error_no_internet';
          return [];
        case DioErrorType.connectionTimeout:
          //error = l?.network_error_timeout ?? "";
          sError = 'network_error_timeout';
          return [];
        case DioErrorType.badResponse: //response
          {
            try {
              late Map<String, dynamic> map;
              if (err.response?.data is! Map<String, dynamic>) {
                final json = jsonDecode((err.response?.data ?? "")) as Map<String, dynamic>;
                map = json;
              } else {
                map = ((err.response?.data as Map<String, dynamic>));
              }
              if (map.containsKey("errors")) {
                final errors = (map["errors"] as Map<String, dynamic>)
                    .entries
                    .map(
                      (e) => ApiError(key: e.key, message: (e.value as List<dynamic>).join("\n")),
                )
                    .toList();
                if (!errorsHandled(errors)) {
                  sError = errors.map((e) => e.message).join("\n");
                }
                return errors;
              } else if (map.containsKey("error_description")) {
                final errors = [
                  ApiError(key: map["error"], message: map["error_description"])
                ];
                if (!errorsHandled(errors)) {
                  sError = errors.map((e) => e.message).join("\n");
                }
                return errors;
              } else if (map.containsKey("messages")) {
                final errors = [ApiError(key: "", message: (map["messages"] as List<dynamic>).join("\n"))];
                if (!errorsHandled(errors)) {
                  sError = errors.map((e) => e.message).join("\n");
                }
                return errors;
              } else if (err.response?.statusCode == 500) {
                //error = l?.network_error_internal_server_error ?? "";
                sError = 'network_error_internal_server_error';
                return [];
              } else {
                return [];
              }
            } catch (e) {
              if (err.response?.statusCode == 500) {
                //error = l?.network_error_internal_server_error ?? "";
                sError = 'network_error_internal_server_error';
                return [];
              } else {
                sError = err.message;
              }
              return [];
            }
          }
        default:
          if (err.response?.statusCode == 500) {
            //error = l?.network_error_internal_server_error ?? "";
            sError = 'network_error_internal_server_error';
            return [];
          } else {
            sError = err.message;
            return [];
          }
      }
    } else {
      if (err.response?.statusCode == 500) {
        //error = l?.network_error_internal_server_error ?? "";
        sError = 'network_error_internal_server_error';
        return [];
      } else {
        sError = err.toString();
        return [];
      }
    }
  }

  bool errorsHandled(List<ApiError> errors) {
    return false;
  }
}
