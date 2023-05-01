import 'package:affairs/core/common_export.dart';

class CryptoCoinsRepository {
  Future<void> getCoinsList() async {
    //https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD
    //https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD');
    debugPrint(response.toString());
  }
}