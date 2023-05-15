import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_model.dart';
import '../../../core/data/http/dio_base_viewmodel.dart';
import '../../../core/get_it_service_locator.dart';

class CryptoCoinsViewModel extends DioBaseViewModel {
  final cryptoCoinsRepository = getIt<CryptoCoinsRepositoryAbstract>();
  List<CryptoCoinModel>?  _cryptoCoinsList;

  List<CryptoCoinModel>? get cryptoCoinsList => _cryptoCoinsList;

  Future<void> loadCryptoCoinsList() async {
    debugPrint('---- loadCryptoCoinsList ');

    try {
      clearError();
      if (_cryptoCoinsList!=null) {
        _cryptoCoinsList = null;
      }
      setLoading=true;
      //notifyListeners();
      _cryptoCoinsList = await cryptoCoinsRepository.getCoinsList();
    } catch (e) {
      debugPrint('---- ERROR in fetchCryptoCoinsList: ${e.toString()}');
      handleApiError(e);
      debugPrint('---- ERROR in fetchCryptoCoinsList: $sError}');
    }

    setLoading=false;
    //notifyListeners();
  }

  CryptoCoinsViewModel() {
   // loadCryptoCoinsList();
  }

}