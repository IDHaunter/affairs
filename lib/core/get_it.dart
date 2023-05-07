import 'package:get_it/get_it.dart';

import 'common_export.dart';
import 'data/http/crypto_coins/crypto_coins_repository.dart';
import 'data/http/crypto_coins/crypto_coins_repository_abstract.dart';

GetIt getIt = GetIt.instance;

//Процедура инициализации всех зависимостей
void setupGetIt() {
  //getIt.registerSingleton<CryptoCoinsRepositoryAbstract>(CryptoCoinsRepository(dio: Dio()));
  //Lazy-синглтон зарегистрируется при первом обращении
  getIt.registerLazySingleton<CryptoCoinsRepositoryAbstract>(() => CryptoCoinsRepository(dio: Dio()));

}