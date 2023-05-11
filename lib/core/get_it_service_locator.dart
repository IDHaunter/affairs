import 'package:get_it/get_it.dart';

import 'common_export.dart';
import 'data/http/crypto_coins/crypto_coins_repository.dart';
import 'data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import 'data/http/dio_client.dart';

GetIt getIt = GetIt.instance;

//Процедура инициализации всех зависимостей
void setupGetIt() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioClient>(DioClient(getIt<Dio>()));

  //getIt.registerSingleton<CryptoCoinsRepositoryAbstract>(CryptoCoinsRepository(dio: Dio()));
  //Lazy-синглтон зарегистрируется при первом обращении
  getIt.registerLazySingleton<CryptoCoinsRepositoryAbstract>(() => CryptoCoinsRepository(dioClient: getIt<DioClient>() ));
}
