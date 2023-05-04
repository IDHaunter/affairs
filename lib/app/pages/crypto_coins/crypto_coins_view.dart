import 'package:affairs/app/pages/crypto_coins/crypto_coin_tile_widget.dart';

import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/crypto_coins_repository.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';

class CryptoCoinsView extends StatefulWidget {
  const CryptoCoinsView({Key? key}) : super(key: key);

  @override
  State<CryptoCoinsView> createState() => _CryptoCoinsViewState();
}

class _CryptoCoinsViewState extends State<CryptoCoinsView> {
  List<CryptoCoin>? _cryptoCoinsList;

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
    setState(() {});
  }

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false),
          Expanded(
            child: (_cryptoCoinsList == null)
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final coin = _cryptoCoinsList![index];
                      return CryptoCoinTile(coin: coin);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                    itemCount: _cryptoCoinsList!.length),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () async {
            await _loadCryptoCoins();
          }),
    );
  }
}