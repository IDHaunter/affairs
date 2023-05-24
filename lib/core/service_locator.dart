import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_service.dart';
import 'common_export.dart';
import 'data/hive/hive_service.dart';
import 'data/http/crypto_coins/crypto_coins_repository.dart';
import 'data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import 'data/http/dio_client.dart';

GetIt getIt = GetIt.instance;

//Процедура инициализации всех зависимостей
void setupGetIt() {
  //Сервисы локального хранения данных ----------
  //SharedPreferences
  getIt.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  //Hive
  getIt.registerSingletonAsync<HiveService>(() async {
    await Hive.initFlutter();
    return HiveService();
  });

  //Сервис авторизации --------------------------
  //getIt.isReady<SharedPreferences>().then((value) => getIt.registerSingleton<AuthHandler>(AuthHandler(getIt<SharedPreferences>())));
  getIt.registerSingletonWithDependencies<AuthService>(
          () => AuthService(getIt<SharedPreferences>()),
      dependsOn: [SharedPreferences]);

  //Сервисы работы с сетью ----------------------
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<DioClient>(DioClient(getIt<Dio>()));
  //getIt.registerSingleton<CryptoCoinsRepositoryAbstract>(CryptoCoinsRepository(dio: Dio()));
  //Lazy-синглтон зарегистрируется при первом обращении (типа экономим ресурсы при старте)
  getIt.registerLazySingleton<CryptoCoinsRepositoryAbstract>(() => CryptoCoinsRepository(dioClient: getIt<DioClient>() ));
}
