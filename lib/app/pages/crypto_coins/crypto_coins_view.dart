import 'package:affairs/app/pages/crypto_coins/crypto_coin_tile_widget.dart';
import 'package:affairs/app/pages/crypto_coins/crypto_coins_viewmodel.dart';

import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/crypto_coins_repository_abstract.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_model.dart';
import '../../../core/get_it_service_locator.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';

class CryptoCoinsView extends StatefulWidget {
  const CryptoCoinsView({Key? key}) : super(key: key);

  @override
  State<CryptoCoinsView> createState() => _CryptoCoinsViewState();
}

class _CryptoCoinsViewState extends State<CryptoCoinsView> {
  List<CryptoCoinModel>? _cryptoCoinsList;
  bool _isLoading = false;
  String? _sError;

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await getIt<CryptoCoinsRepositoryAbstract>()
        .getCoinsList(); //CryptoCoinsRepository(dio: Dio()).getCoinsList();
    setState(() {});
  }

  @override
  void initState() {
    //_loadCryptoCoins();
    Provider.of<CryptoCoinsViewModel>(context, listen: false).loadCryptoCoinsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('---- CryptoCoinsView.build ');
    _isLoading = Provider.of<CryptoCoinsViewModel>(context, listen: true).isLoading;
    _sError = Provider.of<CryptoCoinsViewModel>(context, listen: false).sError;
    _cryptoCoinsList = Provider.of<CryptoCoinsViewModel>(context, listen: false).cryptoCoinsList;
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false, title: 'Crypto rates'),
          Expanded(
              child: (_isLoading) //(_cryptoCoinsList == null)
                  ? const Center(child: CircularProgressIndicator())
                  : (_cryptoCoinsList != null)
                      ? ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            final coin = _cryptoCoinsList![index];
                            return CryptoCoinTile(coin: coin);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              height: 1,
                            );
                          },
                          itemCount: _cryptoCoinsList!.length)
                      : (_sError == null)
                          ? const Center(child: CircularProgressIndicator())
                          : Center(child: Text(_sError ?? 'fucking bad')))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(color: curITheme.icon(), Icons.refresh_outlined),
          onPressed: () async {
            //_loadCryptoCoins();
            Provider.of<CryptoCoinsViewModel>(context, listen: false).loadCryptoCoinsList();
          }),
    );
  }
}
