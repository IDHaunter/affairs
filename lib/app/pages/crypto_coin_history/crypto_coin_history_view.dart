import 'package:affairs/app/pages/crypto_coins/crypto_coins_viewmodel.dart';

import '../../../core/common_export.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';
import 'crypto_coin_history_viewmodel.dart';

class CryptoCoinHistoryView extends StatefulWidget {
  final String cryptoCoinName;
  const CryptoCoinHistoryView({Key? key, required this.cryptoCoinName}) : super(key: key);

  @override
  State<CryptoCoinHistoryView> createState() => _CryptoCoinHistoryViewState();
}

class _CryptoCoinHistoryViewState extends State<CryptoCoinHistoryView> {

  @override
  void initState() {
    //Вызов без addPostFrameCallback вызовет ошибку framework
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CryptoCoinHistoryViewModel>(context, listen: false).loadCryptoCoinHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('---- CryptoCoinHistoryView.build ');

    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false, title: '${widget.cryptoCoinName} history'),
          Center(child: Text('${widget.cryptoCoinName} price')),
          Consumer<CryptoCoinHistoryViewModel>(builder: (context, model, child) =>
              Container(
                  child: (model.isLoading) //(_cryptoCoinsList == null)
                      ? const Center(child: CircularProgressIndicator())
                      : (model.cryptoCoinHistoryModel != null)
                      ? Center(child: Text(model.cryptoCoinHistoryModel!.lastPrice.toString()),)
                      : (model.sError == null)
                      ? const Center(child: CircularProgressIndicator())
                      : Center(child: Text(model.sError ?? 'fucking bad')))

          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(color: curITheme.icon(), Icons.refresh_outlined),
          onPressed: () async {
            Provider.of<CryptoCoinHistoryViewModel>(context, listen: false).loadCryptoCoinHistory();
          }),
    );
  }
}
