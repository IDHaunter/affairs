import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin.dart';

class CryptoCoinTile extends StatelessWidget {
  final CryptoCoin coin;
  const CryptoCoinTile({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(coin.imageURL),
      title: Text(coin.name, style: bold),
      subtitle: Text("${coin.priceInUSD} \$", style: regular),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
