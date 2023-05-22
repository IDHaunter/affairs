import 'dart:convert';

CryptoCoinHistoryResponseModel cryptoCoinHistoryResponseModelFromJson(String str) => CryptoCoinHistoryResponseModel.fromJson(json.decode(str));

class CryptoCoinHistoryResponseModel {
  String response;
  String message;
  bool hasWarning;
  int type;
  RateLimit rateLimit;
  Data data;

  CryptoCoinHistoryResponseModel({
    required this.response,
    required this.message,
    required this.hasWarning,
    required this.type,
    required this.rateLimit,
    required this.data,
  });

  factory CryptoCoinHistoryResponseModel.fromRawJson(String str) => CryptoCoinHistoryResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CryptoCoinHistoryResponseModel.fromJson(Map<String, dynamic> json) => CryptoCoinHistoryResponseModel(
    response: json["Response"],
    message: json["Message"],
    hasWarning: json["HasWarning"],
    type: json["Type"],
    rateLimit: RateLimit.fromJson(json["RateLimit"]),
    data: Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Response": response,
    "Message": message,
    "HasWarning": hasWarning,
    "Type": type,
    "RateLimit": rateLimit.toJson(),
    "Data": data.toJson(),
  };
}

class Data {
  bool aggregated;
  int timeFrom;
  int timeTo;
  List<Datum> data;

  Data({
    required this.aggregated,
    required this.timeFrom,
    required this.timeTo,
    required this.data,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    aggregated: json["Aggregated"],
    timeFrom: json["TimeFrom"],
    timeTo: json["TimeTo"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Aggregated": aggregated,
    "TimeFrom": timeFrom,
    "TimeTo": timeTo,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int time;
  double high;
  double low;
  double open;
  double volumefrom;
  double volumeto;
  double close;
  ConversionType conversionType;
  String conversionSymbol;

  Datum({
    required this.time,
    required this.high,
    required this.low,
    required this.open,
    required this.volumefrom,
    required this.volumeto,
    required this.close,
    required this.conversionType,
    required this.conversionSymbol,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    time: json["time"],
    high: json["high"]?.toDouble(),
    low: json["low"]?.toDouble(),
    open: json["open"]?.toDouble(),
    volumefrom: json["volumefrom"]?.toDouble() ?? 0,
    volumeto: json["volumeto"]?.toDouble() ?? 0,
    close: json["close"]?.toDouble(),
    conversionType: conversionTypeValues.map[json["conversionType"]] ?? ConversionType.DIRECT,
    conversionSymbol: json["conversionSymbol"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "high": high,
    "low": low,
    "open": open,
    "volumefrom": volumefrom,
    "volumeto": volumeto,
    "close": close,
    "conversionType": conversionTypeValues.reverse[conversionType],
    "conversionSymbol": conversionSymbol,
  };
}

enum ConversionType { DIRECT }

final conversionTypeValues = EnumValues({
  "direct": ConversionType.DIRECT
});

class RateLimit {
  RateLimit();

  factory RateLimit.fromRawJson(String str) => RateLimit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RateLimit.fromJson(Map<String, dynamic> json) => RateLimit(
  );

  Map<String, dynamic> toJson() => {
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
