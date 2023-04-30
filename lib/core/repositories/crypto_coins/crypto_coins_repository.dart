import 'package:affairs/core/common_export.dart';

class CryptoCoinsRepository {
  Future<void> getCoinsList() async {
    final response = await Dio().get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV&tsyms=USD');
  }
}