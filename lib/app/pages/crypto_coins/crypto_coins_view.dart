import 'package:affairs/app/pages/crypto_coins/crypto_coin_tile_widget.dart';
import 'package:affairs/app/pages/crypto_coins/crypto_coins_viewmodel.dart';

import '../../../core/common_export.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';

class CryptoCoinsView extends StatefulWidget {
  const CryptoCoinsView({Key? key}) : super(key: key);

  @override
  State<CryptoCoinsView> createState() => _CryptoCoinsViewState();
}

class _CryptoCoinsViewState extends State<CryptoCoinsView> {
  //List<CryptoCoinModel>? _cryptoCoinsList;

  //Future<void> _loadCryptoCoins() async {
  //  _cryptoCoinsList = await getIt<CryptoCoinsRepositoryAbstract>()
  //      .getCoinsList(); //CryptoCoinsRepository(dio: Dio()).getCoinsList();
  //  setState(() {});
  //}

  @override
  void initState() {
    //_loadCryptoCoins();
    //Вызов без addPostFrameCallback вызовет ошибку framework
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CryptoCoinsViewModel>(context, listen: false).loadCryptoCoinsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('---- CryptoCoinsView.build ');
    //_cryptoCoinsList = Provider.of<CryptoCoinsViewModel>(context, listen: false).cryptoCoinsList;
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(
              showCalendar: false,
              showFilter: false,
              showDatePicker: false,
              title: context.l()!.cryptoRates,
              filterDefault: context.l()!.noFilter,
              dateDefault: context.l()!.noDate),
          Consumer<CryptoCoinsViewModel>(
              builder: (context, model, child) => Expanded(
                  child: (model.isLoading) //(_cryptoCoinsList == null)
                      ? const Center(child: CircularProgressIndicator())
                      : (model.cryptoCoinsList != null)
                          ? ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                final coin = model.cryptoCoinsList![index];
                                return CryptoCoinTile(coin: coin);
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const Divider(
                                  height: 1,
                                );
                              },
                              itemCount: model.cryptoCoinsList!.length)
                          : (model.sError == null)
                              ? const Center(child: CircularProgressIndicator())
                              : Center(child: Text(model.sError ?? 'fucking bad')))),
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
