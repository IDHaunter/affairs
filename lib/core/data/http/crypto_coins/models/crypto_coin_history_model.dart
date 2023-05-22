class CryptoCoinEvent {
  final String sDate;
  final double dValue;
  CryptoCoinEvent({required this.sDate, required this.dValue});
}

class CryptoCoinHistoryModel {
  final String cryptoName;
  double diffPrice;
  bool? isGrowUp;
  List<CryptoCoinEvent> cryptoCoinEventsList; //= <CryptoCoinEvent>[];
  CryptoCoinHistoryModel({required this.cryptoName, required this.diffPrice, this.isGrowUp, required this.cryptoCoinEventsList});
}