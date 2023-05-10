import '../../common_export.dart';

//Конфигурация клиента
class DioClient {
// dio instance
  final Dio dio;

  DioClient(this.dio) {
    dio
      //базовый url использовать не обязательно, но если для debug-а и release он отличается, то это must have
      ..options.baseUrl = 'https://min-api.cryptocompare.com/'
      //таймауты
      ..options.connectTimeout = const Duration(milliseconds: 10000)
      ..options.receiveTimeout = const Duration(milliseconds: 10000)
      ..options.responseType = ResponseType.json
      //добавляем общий перехватчик для логирования
      ..interceptors.add(LogInterceptor());
  }
}
