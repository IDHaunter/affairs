import 'package:affairs/core/common_export.dart';
import 'package:affairs/core/data/http/crypto_coins/models/crypto_coin_history_model.dart';
import '../dio_client.dart';
import 'crypto_coins_repository_abstract.dart';
import 'models/crypto_coin_history_response_model.dart';
import 'models/crypto_coin_model.dart';
import 'models/crypto_coins_response_model.dart';

//РЕПОЗИТОРИЙ - реализация методов указанных в одноимённой абстракции. Реализаций может быть много,
//например одна реализация из одного источника, вторая из другого а третья из локального хранилища.

class CryptoCoinsRepository implements CryptoCoinsRepositoryAbstract {
  final DioClient dioClient;

  CryptoCoinsRepository({required this.dioClient});

  @override
  Future<List<CryptoCoinModel>> getCoinsList() async {
    //https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD

    //В Dio есть механизм отмены цепочки запросов с помощью токена, исп. когда юзер не хочет ждать
    //генерит тип ошибки - DioErrorType.cancel
    //CancelToken cancelToken = CancelToken();
    //dio.get('path1', cancelToken: cancelToken);
    //dio.get('path2', cancelToken: cancelToken);

    //В Dio есть механизм перехватчиков (interceptors - используются для кэширования и логирования при выполнении запроса)
    // и трансформеров (transformer - работает по факту выполнения запроса если есть body)

    final Response<dynamic> response = await dioClient.get(
      'data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,SOL,AID,CAG&tsyms=USD',
    );
    //debugPrint(response.toString());
    //Получив в ответ некий JSON нам нужно его разпарсить в модель (лист структурированных объектов)
    //чтобы потом из этого листа сгенерировать ListView через билдер в нашей crypto_coins_view

    //Не зависимо от метода разбора, JSON из API удобно визуализировать (парсить) плагином "Json Parser"
    // (https://plugins.jetbrains.com/plugin/10650-json-parser)

    //МЕТОД 1: Ручной разбор ---------------------------------------------------------------------------------
    /*final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    //собственно пробежим по содержимому представляя его в виде CryptoCoin формируя List

    final List<CryptoCoin> cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String,dynamic>;
      final price = usdData['PRICE'];
      final imageURL = usdData['IMAGEURL'];
      return CryptoCoin(name: e.key, priceInUSD: price, imageURL: 'https://www.cryptocompare.com/$imageURL' );
    }).toList();
    */

    //МЕТОД 2: Разбор с использованием автоматической генерации из JSON https://app.quicktype.io/  -----------
    //при желании можно его юзать только для генерации классов и потом юзать json_serializable
    final cryptoCoinResponseModel = cryptoCoinsResponseModelFromJson(response.toString());

    final List<CryptoCoinModel> cryptoCoinsList = cryptoCoinResponseModel.raw.entries.map((e) {
      final RawUsd rawUsd = (e.value).usd;
      final price = rawUsd.price;
      final imageURL = rawUsd.imageurl;
      return CryptoCoinModel(
          name: e.key, priceInUSD: price, imageURL: 'https://www.cryptocompare.com/$imageURL');
    }).toList();

    //МЕТОД 3: юзать FlutterJsonBeanFactory, но что-то мне не понравилось как он распарсил этот JSON
    //плюс он наделал кучу лишних файлов в которых можно запутаться

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoinHistoryModel> getCoinHistory() async {
    //https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=30
    final Response<dynamic> response = await dioClient.get(
      'data/v2/histoday?fsym=BTC&tsym=USD&limit=30',
    );

    final cryptoCoinHistoryResponseModel = cryptoCoinHistoryResponseModelFromJson(response.toString());

    final cryptoCoinHistoryModel = CryptoCoinHistoryModel(cryptoName: 'BTC', lastPrice: 1, cryptoCoinEventsList: []);
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 100, sDate: '01.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 105, sDate: '02.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 112, sDate: '03.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 106, sDate: '04.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 108, sDate: '05.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 107, sDate: '06.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 99, sDate: '07.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 102, sDate: '08.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 104, sDate: '09.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 108, sDate: '10.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 109, sDate: '11.01.2023'));
    cryptoCoinHistoryModel.cryptoCoinEventsList.add(CryptoCoinEvent(dValue: 116, sDate: '12.01.2023'));
    return cryptoCoinHistoryModel;
  }

}
