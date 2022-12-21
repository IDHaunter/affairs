import 'package:affairs/core/common_export.dart';

//Синтаксический сахар чтобы вместо AppLocalizations.of(context)!.xxx писать context.l()!.xxx
extension LocalizationSugar on BuildContext {
  AppLocalizations? l() {
    return AppLocalizations.of(this);
  }
}

//4 виртуальные градации размеров телефонов
enum PhoneSize { extraSmall, small, medium, large }

//Синтаксический сахар для MediaQuery.of(this).size.xxx и связанной с ней подбором градаций размеров элементов UI
extension DeviceDimensionSugar on BuildContext {
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

  //В зависимости от размера экрана телефона позволяет использовать 4 градации некого размера некого элемента
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
