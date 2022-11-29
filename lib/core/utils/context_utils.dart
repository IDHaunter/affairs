import 'package:affairs/core/common_export.dart';

extension Localization on BuildContext {
  AppLocalizations? l() {
    return AppLocalizations.of(this);
  }
}

enum PhoneSize { extraSmall, small, medium, large }

extension DeviceDimension on BuildContext {
  double screenHeight() {
    return MediaQuery.of(this).size.height;
  }

  double screenWidth() {
    return MediaQuery.of(this).size.width;
  }

  PhoneSize phoneSize() {
    final height = MediaQuery.of(this).size.height;
    if (height <= 568) {
      return PhoneSize.extraSmall;
    } else if (height <= 667) {
      return PhoneSize.small;
    } else if (height <= 812) {
      return PhoneSize.medium;
    } else {
      return PhoneSize.large;
    }
  }

  double valueByPhoneSize(double extraSmall, double small, double medium, double large) {
    switch (phoneSize()) {
      case PhoneSize.extraSmall:
        return extraSmall;
      case PhoneSize.small:
        return small;
      case PhoneSize.medium:
        return medium;
      case PhoneSize.large:
        return large;
    }
  }
}
