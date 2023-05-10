import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_model.dart';
import '../../../core/data/http/http_base_viewmodel.dart';
import '../../../core/get_it_service_locator.dart';

class CryptoCoinsViewModel extends HttpBaseViewModel {
  final cryptoCoinsRepository = getIt<CryptoCoinsRepositoryAbstract>();
  List<CryptoCoinModel>  _cryptoCoinsList = <CryptoCoinModel>[];

  List<CryptoCoinModel> get cryptoCoinsList => _cryptoCoinsList;

  Future<void> loadCryptoCoinsList() async {
    try {
      isLoading=true;
      _cryptoCoinsList = await cryptoCoinsRepository.getCoinsList();
    } catch (e) {
      debugPrint('---- ERROR in fetchCryptoCoinsList: ${e.toString()}');
      handleApiError(e);
      debugPrint('---- ERROR in fetchCryptoCoinsList: $sError}');
      notifyListeners();
    }

    isLoading=false;
    notifyListeners();
  }



}