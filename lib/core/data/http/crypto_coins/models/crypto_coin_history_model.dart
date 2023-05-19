class CryptoCoinEvent {
  final String sDate;
  final double dValue;
  CryptoCoinEvent({required this.sDate, required this.dValue});
}

class CryptoCoinHistoryModel {
  final String cryptoName;
  double lastPrice;
  bool? isGrowUp;
  List<CryptoCoinEvent> cryptoCoinEventsList; //= <CryptoCoinEvent>[];
  CryptoCoinHistoryModel({required this.cryptoName, required this.lastPrice, this.isGrowUp, required this.cryptoCoinEventsList});
}