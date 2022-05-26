import 'package:espwithflutter/streams/voltage.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import 'model/live_data.dart';
import 'stream_builder/current_voltage_builder.dart';
import 'stream_builder/num_builder.dart';
import 'stream_builder/power_builder.dart';
import 'streams/current.dart';
import 'streams/num1.dart';
import 'streams/num2.dart';
import 'streams/power.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //voltage
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  //Current
  late List<LiveData> chartData2;
  late ChartSeriesController _chartSeriesController2;

  @override
  void initState() {
    //voltage
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    //Current
    chartData2 = getChartData2();
    Timer.periodic(const Duration(seconds: 1), updateDataSource2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Smart Fountain'),
          backgroundColor: Colors.deepOrange,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(height: 10),
                //num1,num2
                Row(
                  children: [
                    Expanded(

                      child: buildStreamBuilder(Num1.fetchData(), 'Num1'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(child: buildStreamBuilder(Num2.fetchData(), 'Num2')),
                  ],
                ),
                const SizedBox(height: 25),
                //display current
                buildStreamBuilder2(Current.fetchData(), 'Current'),
                const SizedBox(height: 25),
                //display voltage
                buildStreamBuilder2(Voltage.fetchData(), 'Voltage'),
                const SizedBox(height: 25),
                //display power
                buildStreamBuilder3(Power.fetchData(), 'Power'),
                const SizedBox(height: 25),
                //display chart for voltage
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                    series: <LineSeries<LiveData, int>>[
                      LineSeries<LiveData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: chartData,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (LiveData sales, _) => sales.time,
                        yValueMapper: (LiveData sales, _) => sales.voltage,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 1,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                      interval: 0.5,
                      title: AxisTitle(text: 'Voltage (V)'),
                    ),
                  ),
                ),
                //display chart for current
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                    series: <LineSeries<LiveData, int>>[
                      LineSeries<LiveData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController2 = controller;
                        },
                        dataSource: chartData2,
                        color: const Color.fromRGBO(192, 108, 132, 1),
                        xValueMapper: (LiveData sales, _) => sales.time,
                        yValueMapper: (LiveData sales, _) => sales.voltage,
                      )
                    ],
                    primaryXAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        interval: 1,
                        title: AxisTitle(text: 'Time (seconds)')),
                    primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                      interval: 0.5,
                      title: AxisTitle(text: 'Current (A)'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int time = 7;
  int v = 0;
  int c = 0;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, Voltage.data![v]));
    v++;
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 1),
      LiveData(1, 1),
      LiveData(2, 1),
      LiveData(3, 5),
      LiveData(4, 6),
      LiveData(5, 10),
      LiveData(6, 4),
    ];
  }


  void updateDataSource2(Timer timer) {
    chartData2.add(LiveData(time++, Current.dataOfCurrent![c]));
    c++;
    chartData2.removeAt(0);
    _chartSeriesController2.updateDataSource(
        addedDataIndex: chartData2.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData2() {
    return <LiveData>[
      LiveData(0, 1),
      LiveData(1, 1),
      LiveData(2, 1),
      LiveData(3, 5),
      LiveData(4, 6),
      LiveData(5, 10),
      LiveData(6, 4),
    ];
  }
}
