import '../../../core/common_export.dart';
import '../../../core/repositories/crypto_coins/crypto_coins_repository.dart';
import '../../widgets/custom_navigation_drawer.dart';
import '../../widgets/top_bar.dart';

class CryptoCoinsPage extends StatefulWidget {
  const CryptoCoinsPage({Key? key}) : super(key: key);

  @override
  State<CryptoCoinsPage> createState() => _CryptoCoinsPageState();
}

class _CryptoCoinsPageState extends State<CryptoCoinsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      body: Column(
        children: <Widget>[
          TopBar(showCalendar: false, showFilter: false, showDatePicker: false),
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Text('BitCoin $index');
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: 3),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton( child: const Icon(Icons.download),
          onPressed: () {
        CryptoCoinsRepository().getCoinsList();
      }),
    );
    ;
  }
}
