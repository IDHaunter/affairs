import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_history_model.dart';
import '../../../core/data/http/dio_base_viewmodel.dart';
import '../../../core/service_locator.dart';

class CryptoCoinHistoryViewModel extends DioBaseViewModel {
  final String cryptoCoinName;
  CryptoCoinHistoryModel?  _cryptoCoinHistoryModel;

  CryptoCoinHistoryViewModel({required this.cryptoCoinName});

  final cryptoCoinsRepository = getIt<CryptoCoinsRepositoryAbstract>();

  CryptoCoinHistoryModel? get cryptoCoinHistoryModel => _cryptoCoinHistoryModel;

  Future<void> loadCryptoCoinHistory() async {
    debugPrint('---- loadCryptoCoinHistory ');

    try {
      clearError();
      if (_cryptoCoinHistoryModel!=null) {
        _cryptoCoinHistoryModel = null;
      }
      setLoading=true;
      _cryptoCoinHistoryModel = await cryptoCoinsRepository.getCoinHistory(cryptoCoinName: cryptoCoinName);
    } catch (e) {
      debugPrint('---- ERROR in loadCryptoCoinHistory: ${e.toString()}');
      handleApiError(e);
      debugPrint('---- ERROR in loadCryptoCoinHistory: $sError}');
    }

    setLoading=false;
  }

}