import '../../common_export.dart';

class DioBaseViewModel extends ChangeNotifier {
  //любой http запрос оканчивается либо получением данных или ошибкой
  //Базовая хранит статус получения данных (isLoading) и процессом расшифровки ошибок (sError),
  //уведомления реализуются во ViewModel которая

  //Для отображения ошибки на разных языках используем пакет локализации
  AppLocalizations? l;

  //получение данных -----------------------------------------------------------------------------------------
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    //notifyListeners();
  }

  //обработка ошибок -----------------------------------------------------------------------------------------
  //У ошибки всегда есть текст для отображения пользователю
  // и потенциально может быть список ошибок в ответе от API но тут уже зависит от реализации на стороне сервера
  String? _sError;
  String? get sError => _sError;

  void clearError() {
    _sError = null;
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops! something went wrong';
    }
  }

   handleApiError(dynamic err) {
    if (err is DioError) {
      //обработка ошибок Dio --------------------------------------------
      DioError dioError=err;

      switch (dioError.type) {
        case DioErrorType.cancel:
          //_sError = l?.error_dio_cancel ?? "";
          _sError = "Request to API server was cancelled";
          break;
        case DioErrorType.connectionError:
          _sError = "Connection error";
          break;
        case DioErrorType.badCertificate:
          _sError = "Bad certificate";
          break;
        case DioErrorType.connectionTimeout:
          _sError = "Connection timeout with API server";
          break;
        case DioErrorType.receiveTimeout:
          _sError = "Receive timeout in connection with API server";
          break;
        case DioErrorType.sendTimeout:
          _sError = "Send timeout in connection with API server";
          break;
        case DioErrorType.badResponse:
          _sError = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
          break;
        case DioErrorType.unknown:
          if (dioError.message != null) {
            if (dioError.message!.contains("SocketException")) {
              _sError = 'No Internet (socket exception)';
            } else {_sError = dioError.message;}
            break;
          }
          _sError = "No Internet";
          break;
        default:
          _sError = "Something went wrong";
          break;
      }

    } else {
        //обработка прочих ошибок
        _sError = err.toString();
        //return _sError ?? 'Unexpected error occurred';
      }
    }

  }

