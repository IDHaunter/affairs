import 'package:affairs/app/pages/crypto_coins/crypto_coins_viewmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_history_model.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';
import 'crypto_coin_history_chart_widget.dart';
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
          TopBar(
              showCalendar: false, showFilter: false, showDatePicker: false, title: '${widget.cryptoCoinName} history'),
          Consumer<CryptoCoinHistoryViewModel>(builder: (context, model, child) {
            return Expanded(
                child: (model.isLoading)
                    ? const Center(child: CircularProgressIndicator())
                    : (model.cryptoCoinHistoryModel != null)
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('1 ${widget.cryptoCoinName} = ${model.cryptoCoinHistoryModel!.lastPrice} \$'),
                                  Icon(color: curITheme.accent(), Icons.arrow_drop_up_outlined)
                                ],
                              ),
                              Expanded(
                                  child: Center(
                                      child: CryptoCoinHistoryChart(data: model.cryptoCoinHistoryModel!.cryptoCoinEventsList ) )),
                            ],
                          )
                        : (model.sError == null)
                            ? const Center(child: CircularProgressIndicator())
                            : Center(child: Text(model.sError ?? 'fucking bad')));
          })
        ],
      ),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              child: Icon(color: curITheme.icon(), Icons.refresh_outlined),
              onPressed: () async {
                Provider.of<CryptoCoinHistoryViewModel>(context, listen: false).loadCryptoCoinHistory();
              }),
          const SizedBox(height: 20, width: 20,),
        ],
      ),
    );
  }
}
