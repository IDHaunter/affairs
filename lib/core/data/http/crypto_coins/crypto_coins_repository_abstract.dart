import 'models/crypto_coin_model.dart';

//АБСТРАКЦИЯ РЕПОЗИТОРИЯ - это декларация методов и их необходимых результатов, этакий "контракт"
abstract class CryptoCoinsRepositoryAbstract {
  // т.е. нам нужен лист криптокоинов, а откуда (http, ftp, sqLite...) и кто (какой именно класс) их возьмёт нам не принципиально
  Future<List<CryptoCoinModel>> getCoinsList();
}