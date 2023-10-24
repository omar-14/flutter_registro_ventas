import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/config/theme/theme_provider.dart';
import 'package:intventory/features/shared/shared.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded),
              onPressed: () {
                // ref
                //     .read(themeProvider.notifier)
                //     .update((isDarkmode) => !isDarkmode);
                ref.read(themeNotifierProvider.notifier).toggleDarkmode();
              })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ir a ventas"),
        icon: const Icon(Icons.store_mall_directory_sharp),
        onPressed: () {
          context.push("/sales");
        },
      ),
      body: const _MyChatView(),
    );
  }
}

class _MyChatView extends StatefulWidget {
  const _MyChatView();

  @override
  State<_MyChatView> createState() => __MyChatViewState();
}

class __MyChatViewState extends State<_MyChatView> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      //Initialize the chart widget
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: const Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            //Initialize the spark charts widget
            child: SfSparkLineChart.custom(
              //Enable the trackball
              trackball: const SparkChartTrackball(
                  activationMode: SparkChartActivationMode.tap),
              //Enable marker
              marker: const SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all),
              //Enable data label
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              xValueMapper: (int index) => data[index].year,
              yValueMapper: (int index) => data[index].sales,
              dataCount: 5,
            ),
          ),
        ),
      ),
    ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
