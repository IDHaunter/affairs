import 'dart:convert';

CryptoCoinsResponseModel cryptoCoinsResponseModelFromJson(String str) => CryptoCoinsResponseModel.fromJson(json.decode(str));

String cryptoCoinsResponseModelToJson(CryptoCoinsResponseModel data) => json.encode(data.toJson());

class CryptoCoinsResponseModel {
  final Map<String, Raw> raw;
  final Map<String, Display> display;

  CryptoCoinsResponseModel({
    required this.raw,
    required this.display,
  });

  factory CryptoCoinsResponseModel.fromJson(Map<String, dynamic> json) => CryptoCoinsResponseModel(
    raw: Map.from(json["RAW"]).map((k, v) => MapEntry<String, Raw>(k, Raw.fromJson(v))),
    display: Map.from(json["DISPLAY"]).map((k, v) => MapEntry<String, Display>(k, Display.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "RAW": Map.from(raw).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "DISPLAY": Map.from(display).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Display {
  final DisplayUsd usd;

  Display({
    required this.usd,
  });

  factory Display.fromJson(Map<String, dynamic> json) => Display(
    usd: DisplayUsd.fromJson(json["USD"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd.toJson(),
  };
}

class DisplayUsd {
  final String fromsymbol;
  final String tosymbol;
  final String market;
  final String price;
  final String lastupdate;
  final String lastvolume;
  final String lastvolumeto;
  final String lasttradeid;
  final String volumeday;
  final String volumedayto;
  final String volume24Hour;
  final String volume24Hourto;
  final String openday;
  final String highday;
  final String lowday;
  final String open24Hour;
  final String high24Hour;
  final String low24Hour;
  final String lastmarket;
  final String volumehour;
  final String volumehourto;
  final String openhour;
  final String highhour;
  final String lowhour;
  final String toptiervolume24Hour;
  final String toptiervolume24Hourto;
  final String change24Hour;
  final String changepct24Hour;
  final String changeday;
  final String changepctday;
  final String changehour;
  final String changepcthour;
  final String conversiontype;
  final String conversionsymbol;
  final String conversionlastupdate;
  final String supply;
  final String mktcap;
  final String mktcappenalty;
  final String circulatingsupply;
  final String circulatingsupplymktcap;
  final String totalvolume24H;
  final String totalvolume24Hto;
  final String totaltoptiervolume24H;
  final String totaltoptiervolume24Hto;
  final String imageurl;

  DisplayUsd({
    required this.fromsymbol,
    required this.tosymbol,
    required this.market,
    required this.price,
    required this.lastupdate,
    required this.lastvolume,
    required this.lastvolumeto,
    required this.lasttradeid,
    required this.volumeday,
    required this.volumedayto,
    required this.volume24Hour,
    required this.volume24Hourto,
    required this.openday,
    required this.highday,
    required this.lowday,
    required this.open24Hour,
    required this.high24Hour,
    required this.low24Hour,
    required this.lastmarket,
    required this.volumehour,
    required this.volumehourto,
    required this.openhour,
    required this.highhour,
    required this.lowhour,
    required this.toptiervolume24Hour,
    required this.toptiervolume24Hourto,
    required this.change24Hour,
    required this.changepct24Hour,
    required this.changeday,
    required this.changepctday,
    required this.changehour,
    required this.changepcthour,
    required this.conversiontype,
    required this.conversionsymbol,
    required this.conversionlastupdate,
    required this.supply,
    required this.mktcap,
    required this.mktcappenalty,
    required this.circulatingsupply,
    required this.circulatingsupplymktcap,
    required this.totalvolume24H,
    required this.totalvolume24Hto,
    required this.totaltoptiervolume24H,
    required this.totaltoptiervolume24Hto,
    required this.imageurl,
  });

  factory DisplayUsd.fromJson(Map<String, dynamic> json) => DisplayUsd(
    fromsymbol: json["FROMSYMBOL"],
    tosymbol: json["TOSYMBOL"],
    market: json["MARKET"],
    price: json["PRICE"],
    lastupdate: json["LASTUPDATE"],
    lastvolume: json["LASTVOLUME"],
    lastvolumeto: json["LASTVOLUMETO"],
    lasttradeid: json["LASTTRADEID"],
    volumeday: json["VOLUMEDAY"],
    volumedayto: json["VOLUMEDAYTO"],
    volume24Hour: json["VOLUME24HOUR"],
    volume24Hourto: json["VOLUME24HOURTO"],
    openday: json["OPENDAY"],
    highday: json["HIGHDAY"],
    lowday: json["LOWDAY"],
    open24Hour: json["OPEN24HOUR"],
    high24Hour: json["HIGH24HOUR"],
    low24Hour: json["LOW24HOUR"],
    lastmarket: json["LASTMARKET"],
    volumehour: json["VOLUMEHOUR"],
    volumehourto: json["VOLUMEHOURTO"],
    openhour: json["OPENHOUR"],
    highhour: json["HIGHHOUR"],
    lowhour: json["LOWHOUR"],
    toptiervolume24Hour: json["TOPTIERVOLUME24HOUR"],
    toptiervolume24Hourto: json["TOPTIERVOLUME24HOURTO"],
    change24Hour: json["CHANGE24HOUR"],
    changepct24Hour: json["CHANGEPCT24HOUR"],
    changeday: json["CHANGEDAY"],
    changepctday: json["CHANGEPCTDAY"],
    changehour: json["CHANGEHOUR"],
    changepcthour: json["CHANGEPCTHOUR"],
    conversiontype: json["CONVERSIONTYPE"],
    conversionsymbol: json["CONVERSIONSYMBOL"],
    conversionlastupdate: json["CONVERSIONLASTUPDATE"],
    supply: json["SUPPLY"],
    mktcap: json["MKTCAP"],
    mktcappenalty: json["MKTCAPPENALTY"],
    circulatingsupply: json["CIRCULATINGSUPPLY"],
    circulatingsupplymktcap: json["CIRCULATINGSUPPLYMKTCAP"],
    totalvolume24H: json["TOTALVOLUME24H"],
    totalvolume24Hto: json["TOTALVOLUME24HTO"],
    totaltoptiervolume24H: json["TOTALTOPTIERVOLUME24H"],
    totaltoptiervolume24Hto: json["TOTALTOPTIERVOLUME24HTO"],
    imageurl: json["IMAGEURL"],
  );

  Map<String, dynamic> toJson() => {
    "FROMSYMBOL": fromsymbol,
    "TOSYMBOL": tosymbol,
    "MARKET": market,
    "PRICE": price,
    "LASTUPDATE": lastupdate,
    "LASTVOLUME": lastvolume,
    "LASTVOLUMETO": lastvolumeto,
    "LASTTRADEID": lasttradeid,
    "VOLUMEDAY": volumeday,
    "VOLUMEDAYTO": volumedayto,
    "VOLUME24HOUR": volume24Hour,
    "VOLUME24HOURTO": volume24Hourto,
    "OPENDAY": openday,
    "HIGHDAY": highday,
    "LOWDAY": lowday,
    "OPEN24HOUR": open24Hour,
    "HIGH24HOUR": high24Hour,
    "LOW24HOUR": low24Hour,
    "LASTMARKET": lastmarket,
    "VOLUMEHOUR": volumehour,
    "VOLUMEHOURTO": volumehourto,
    "OPENHOUR": openhour,
    "HIGHHOUR": highhour,
    "LOWHOUR": lowhour,
    "TOPTIERVOLUME24HOUR": toptiervolume24Hour,
    "TOPTIERVOLUME24HOURTO": toptiervolume24Hourto,
    "CHANGE24HOUR": change24Hour,
    "CHANGEPCT24HOUR": changepct24Hour,
    "CHANGEDAY": changeday,
    "CHANGEPCTDAY": changepctday,
    "CHANGEHOUR": changehour,
    "CHANGEPCTHOUR": changepcthour,
    "CONVERSIONTYPE": conversiontype,
    "CONVERSIONSYMBOL": conversionsymbol,
    "CONVERSIONLASTUPDATE": conversionlastupdate,
    "SUPPLY": supply,
    "MKTCAP": mktcap,
    "MKTCAPPENALTY": mktcappenalty,
    "CIRCULATINGSUPPLY": circulatingsupply,
    "CIRCULATINGSUPPLYMKTCAP": circulatingsupplymktcap,
    "TOTALVOLUME24H": totalvolume24H,
    "TOTALVOLUME24HTO": totalvolume24Hto,
    "TOTALTOPTIERVOLUME24H": totaltoptiervolume24H,
    "TOTALTOPTIERVOLUME24HTO": totaltoptiervolume24Hto,
    "IMAGEURL": imageurl,
  };
}

class Raw {
  final RawUsd usd;

  Raw({
    required this.usd,
  });

  factory Raw.fromJson(Map<String, dynamic> json) => Raw(
    usd: RawUsd.fromJson(json["USD"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd.toJson(),
  };
}

class RawUsd {
  final String type;
  final String market;
  final String fromsymbol;
  final String tosymbol;
  final String flags;
  final double price;
  final int lastupdate;
  final double median;
  final double lastvolume;
  final double lastvolumeto;
  final String lasttradeid;
  final double volumeday;
  final double volumedayto;
  final double volume24Hour;
  final double volume24Hourto;
  final double openday;
  final double highday;
  final double lowday;
  final double open24Hour;
  final double high24Hour;
  final double low24Hour;
  final String lastmarket;
  final double volumehour;
  final double volumehourto;
  final double openhour;
  final double highhour;
  final double lowhour;
  final double toptiervolume24Hour;
  final double toptiervolume24Hourto;
  final double change24Hour;
  final double changepct24Hour;
  final double changeday;
  final double changepctday;
  final double changehour;
  final double changepcthour;
  final String conversiontype;
  final String conversionsymbol;
  final int conversionlastupdate;
  final double supply;
  final double mktcap;
  final int mktcappenalty;
  final double circulatingsupply;
  final double circulatingsupplymktcap;
  final double totalvolume24H;
  final double totalvolume24Hto;
  final double totaltoptiervolume24H;
  final double totaltoptiervolume24Hto;
  final String imageurl;

  RawUsd({
    required this.type,
    required this.market,
    required this.fromsymbol,
    required this.tosymbol,
    required this.flags,
    required this.price,
    required this.lastupdate,
    required this.median,
    required this.lastvolume,
    required this.lastvolumeto,
    required this.lasttradeid,
    required this.volumeday,
    required this.volumedayto,
    required this.volume24Hour,
    required this.volume24Hourto,
    required this.openday,
    required this.highday,
    required this.lowday,
    required this.open24Hour,
    required this.high24Hour,
    required this.low24Hour,
    required this.lastmarket,
    required this.volumehour,
    required this.volumehourto,
    required this.openhour,
    required this.highhour,
    required this.lowhour,
    required this.toptiervolume24Hour,
    required this.toptiervolume24Hourto,
    required this.change24Hour,
    required this.changepct24Hour,
    required this.changeday,
    required this.changepctday,
    required this.changehour,
    required this.changepcthour,
    required this.conversiontype,
    required this.conversionsymbol,
    required this.conversionlastupdate,
    required this.supply,
    required this.mktcap,
    required this.mktcappenalty,
    required this.circulatingsupply,
    required this.circulatingsupplymktcap,
    required this.totalvolume24H,
    required this.totalvolume24Hto,
    required this.totaltoptiervolume24H,
    required this.totaltoptiervolume24Hto,
    required this.imageurl,
  });

  factory RawUsd.fromJson(Map<String, dynamic> json) => RawUsd(
    type: json["TYPE"],
    market: json["MARKET"],
    fromsymbol: json["FROMSYMBOL"],
    tosymbol: json["TOSYMBOL"],
    flags: json["FLAGS"],
    price: json["PRICE"]?.toDouble(),
    lastupdate: json["LASTUPDATE"],
    median: json["MEDIAN"]?.toDouble(),
    lastvolume: json["LASTVOLUME"]?.toDouble(),
    lastvolumeto: json["LASTVOLUMETO"]?.toDouble(),
    lasttradeid: json["LASTTRADEID"],
    volumeday: json["VOLUMEDAY"]?.toDouble(),
    volumedayto: json["VOLUMEDAYTO"]?.toDouble(),
    volume24Hour: json["VOLUME24HOUR"]?.toDouble(),
    volume24Hourto: json["VOLUME24HOURTO"]?.toDouble(),
    openday: json["OPENDAY"]?.toDouble(),
    highday: json["HIGHDAY"]?.toDouble(),
    lowday: json["LOWDAY"]?.toDouble(),
    open24Hour: json["OPEN24HOUR"]?.toDouble(),
    high24Hour: json["HIGH24HOUR"]?.toDouble(),
    low24Hour: json["LOW24HOUR"]?.toDouble(),
    lastmarket: json["LASTMARKET"],
    volumehour: json["VOLUMEHOUR"]?.toDouble(),
    volumehourto: json["VOLUMEHOURTO"]?.toDouble(),
    openhour: json["OPENHOUR"]?.toDouble(),
    highhour: json["HIGHHOUR"]?.toDouble(),
    lowhour: json["LOWHOUR"]?.toDouble(),
    toptiervolume24Hour: json["TOPTIERVOLUME24HOUR"]?.toDouble(),
    toptiervolume24Hourto: json["TOPTIERVOLUME24HOURTO"]?.toDouble(),
    change24Hour: json["CHANGE24HOUR"]?.toDouble(),
    changepct24Hour: json["CHANGEPCT24HOUR"]?.toDouble(),
    changeday: json["CHANGEDAY"]?.toDouble(),
    changepctday: json["CHANGEPCTDAY"]?.toDouble(),
    changehour: json["CHANGEHOUR"]?.toDouble(),
    changepcthour: json["CHANGEPCTHOUR"]?.toDouble(),
    conversiontype: json["CONVERSIONTYPE"],
    conversionsymbol: json["CONVERSIONSYMBOL"],
    conversionlastupdate: json["CONVERSIONLASTUPDATE"],
    supply: json["SUPPLY"]?.toDouble(),
    mktcap: json["MKTCAP"]?.toDouble(),
    mktcappenalty: json["MKTCAPPENALTY"],
    circulatingsupply: json["CIRCULATINGSUPPLY"]?.toDouble(),
    circulatingsupplymktcap: json["CIRCULATINGSUPPLYMKTCAP"]?.toDouble(),
    totalvolume24H: json["TOTALVOLUME24H"]?.toDouble(),
    totalvolume24Hto: json["TOTALVOLUME24HTO"]?.toDouble(),
    totaltoptiervolume24H: json["TOTALTOPTIERVOLUME24H"]?.toDouble(),
    totaltoptiervolume24Hto: json["TOTALTOPTIERVOLUME24HTO"]?.toDouble(),
    imageurl: json["IMAGEURL"],
  );

  Map<String, dynamic> toJson() => {
    "TYPE": type,
    "MARKET": market,
    "FROMSYMBOL": fromsymbol,
    "TOSYMBOL": tosymbol,
    "FLAGS": flags,
    "PRICE": price,
    "LASTUPDATE": lastupdate,
    "MEDIAN": median,
    "LASTVOLUME": lastvolume,
    "LASTVOLUMETO": lastvolumeto,
    "LASTTRADEID": lasttradeid,
    "VOLUMEDAY": volumeday,
    "VOLUMEDAYTO": volumedayto,
    "VOLUME24HOUR": volume24Hour,
    "VOLUME24HOURTO": volume24Hourto,
    "OPENDAY": openday,
    "HIGHDAY": highday,
    "LOWDAY": lowday,
    "OPEN24HOUR": open24Hour,
    "HIGH24HOUR": high24Hour,
    "LOW24HOUR": low24Hour,
    "LASTMARKET": lastmarket,
    "VOLUMEHOUR": volumehour,
    "VOLUMEHOURTO": volumehourto,
    "OPENHOUR": openhour,
    "HIGHHOUR": highhour,
    "LOWHOUR": lowhour,
    "TOPTIERVOLUME24HOUR": toptiervolume24Hour,
    "TOPTIERVOLUME24HOURTO": toptiervolume24Hourto,
    "CHANGE24HOUR": change24Hour,
    "CHANGEPCT24HOUR": changepct24Hour,
    "CHANGEDAY": changeday,
    "CHANGEPCTDAY": changepctday,
    "CHANGEHOUR": changehour,
    "CHANGEPCTHOUR": changepcthour,
    "CONVERSIONTYPE": conversiontype,
    "CONVERSIONSYMBOL": conversionsymbol,
    "CONVERSIONLASTUPDATE": conversionlastupdate,
    "SUPPLY": supply,
    "MKTCAP": mktcap,
    "MKTCAPPENALTY": mktcappenalty,
    "CIRCULATINGSUPPLY": circulatingsupply,
    "CIRCULATINGSUPPLYMKTCAP": circulatingsupplymktcap,
    "TOTALVOLUME24H": totalvolume24H,
    "TOTALVOLUME24HTO": totalvolume24Hto,
    "TOTALTOPTIERVOLUME24H": totaltoptiervolume24H,
    "TOTALTOPTIERVOLUME24HTO": totaltoptiervolume24Hto,
    "IMAGEURL": imageurl,
  };
}
