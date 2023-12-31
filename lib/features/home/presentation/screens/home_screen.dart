import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Agregar Venta"),
        icon: const Icon(Icons.add),
        onPressed: () {},
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
    return Column(children: [
      //Initialize the chart widget
      SfCartesianChart(
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
      Padding(
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
      )
    ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
