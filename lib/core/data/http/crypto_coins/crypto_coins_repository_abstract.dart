import 'models/crypto_coin_model.dart';

//АБСТРАКЦИЯ РЕПОЗИТОРИЯ - это декларация методов и их необходимых результатов, этакий "контракт"
//необходимость создания абстракции репозитория вопрос спорный, но при наличии нескольких источников данных
//это обретает смысл т.к. в getIt мы регистрируем абстракцию и в последствии везде ссылаемся на неё
//т.е. мы оставляем за собой возможность переключения между реализациями этой абстракции
abstract class CryptoCoinsRepositoryAbstract {
  // т.е. нам нужен лист криптокоинов, а откуда (http, ftp, sqLite...) и кто (какой именно класс) их возьмёт нам не принципиально
  Future<List<CryptoCoinModel>> getCoinsList();
}