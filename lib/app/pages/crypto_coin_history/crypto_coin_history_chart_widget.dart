import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/common_export.dart';
import '../../../core/data/http/crypto_coins/models/crypto_coin_history_model.dart';

class CryptoCoinHistoryChart extends StatelessWidget {
  final List<CryptoCoinEvent> data;

  const CryptoCoinHistoryChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      //title: ChartTitle(text: 'History line'),
      //Ось Х предполагает строчные значения, значит  CategoryAxis
      primaryXAxis: CategoryAxis(),
      //Ось Y предполагает числовые значения, значит NumericAxis
      primaryYAxis: NumericAxis(),
      legend: Legend(isVisible: true),
      margin: const EdgeInsets.all(0),
      borderWidth: 0,
      borderColor: Colors.transparent,
      // series - это List числовых рядов кот. могут быть различных типопв
      // и накладываться друг на друга
      series: <ChartSeries<CryptoCoinEvent, String>>[
        SplineAreaSeries(
            dataSource: data,
            xValueMapper: (CryptoCoinEvent event, _) => event.sDate,
            yValueMapper: (CryptoCoinEvent event, _) => event.dValue,
            gradient: curITheme.accentGradientVertical(),
        ),
        
      ],
    );
  }
}
