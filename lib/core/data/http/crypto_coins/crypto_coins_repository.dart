import 'package:affairs/core/common_export.dart';

import 'models/crypto_coin.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    //https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD
    final response = await Dio().get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,SOL,AID,CAG&tsyms=USD');
    debugPrint(response.toString());
    //Получив в ответ некий JSON нам нужно его разпарсить в лист наших структурированных объектов
    //чтобы потом из этого листа сгенерировать ListView через билдер в нашей crypto_coins_view
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    //собственно пробежим по содержимому представляя его в виде CryptoCoin формируя List
    final List<CryptoCoin> cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String,dynamic>;
      final price = usdData['PRICE'];
      final imageURL = usdData['IMAGEURL'];
      return CryptoCoin(name: e.key, priceInUSD: price, imageURL: 'https://www.cryptocompare.com/$imageURL' );
    }).toList();
        return cryptoCoinsList;
    }
}