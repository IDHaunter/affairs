import 'crypto_coins_response_model.dart';

class CryptoCoinModel {
  final String name;
  final double priceInUSD;
  final String imageURL;
  CryptoCoinModel({required this.name, required this.priceInUSD, required this.imageURL});
}
