import 'models/crypto_coin_history_model.dart';
import 'models/crypto_coin_model.dart';

//АБСТРАКЦИЯ РЕПОЗИТОРИЯ - это декларация методов и их необходимых результатов, этакий "контракт"
//необходимость создания абстракции репозитория вопрос спорный, но при наличии нескольких источников данных
//это обретает смысл т.к. в getIt мы регистрируем абстракцию и в последствии везде ссылаемся на неё
//т.е. мы оставляем за собой возможность переключения между реализациями этой абстракции
abstract class CryptoCoinsRepositoryAbstract {
  // т.е. нам нужен лист криптокоинов, а откуда (http, ftp, sqLite...) и кто (какой именно класс) их возьмёт нам не принципиально
  Future<List<CryptoCoinModel>> getCoinsList();

  //также нам понадобится история изменения цены за последние 30 дней в виде листа ивентов,
  // наименования крипты, последней цены и индикатор роста которые мы завернули в CryptoCoinHistoryModel
  //https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=30
  Future<CryptoCoinHistoryModel> getCoinHistory();
}