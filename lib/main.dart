import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'График сделки смены'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _chartHeight = 850;
  final List<String> _workerNames1 = [
    "Иванов И.И.",
    "Петров П.П.",
    "Сидоров С.С.",
    "Кузнецов К.К."
  ];
  final List<String> _workerNames2 = [
    "Смирнов С.С.",
    "Федоров Ф.Ф.",
    "Алексеев А.А.",
    "Григорьев Г.Г."
  ];
  final List<double> _barChartValues1 = [1500, 1607, 3506, 2900];
  final List<double> _barChartValues2 = [3534, 2783, 754, 4174];
  String _chartTitle = "Переупаковка Стол (Штуки)";
  List<double> _currentBarChartValues = [];
  List<String> _currentWorkerNames = [];
  @override
  void initState() {
    super.initState();
    _currentBarChartValues = _barChartValues1;
    _currentWorkerNames = _workerNames1;
    Timer.periodic(const Duration(seconds: 15), (timer) {
      _changeChartData();
    });
  }

  void _changeChartData() {
    setState(() {
      if (_currentBarChartValues == _barChartValues1) {
        _currentBarChartValues = _barChartValues2;
        _currentWorkerNames = _workerNames2;
        _chartTitle = "Другой график";
      } else {
        _currentBarChartValues = _barChartValues1;
        _currentWorkerNames = _workerNames1;
        _chartTitle = "Переупаковка Стол (Штуки)";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 225, 255),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            _chartTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Expanded(child: _buildChart()),
          //     ],
          //   ),
          // ),
          Expanded(child: _buildChart()),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Padding(
        //padding: const EdgeInsets.only(top: 0, right: 525, left: 525, bottom: 0),
        padding: const EdgeInsets.symmetric(horizontal: 525.0),
        child: Transform.rotate(
          angle: pi / 2,
          child: SizedBox(
            height: _chartHeight,
            child: Stack(children: [
              BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups:
                      _currentBarChartValues.asMap().entries.map((entry) {
                    int index = entry.key;
                    double value = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: value,
                          color: const Color.fromARGB(255, 34, 167, 201),
                          width: 120,
                          borderRadius: BorderRadius.circular(3),
                          // backDrawRodData: BackgroundBarChartRodData(
                          //   show: true,
                          //   toY: value,
                          //   color: Colors.transparent,
                          //   getRodBackDraw: (value, meta) => Container(
                          //     alignment: Alignment.topCenter,
                          //     child: Text(
                          //       value.toInt().toString(),
                          //       style: const TextStyle(
                          //         color: Colors.black,
                          //         fontSize: 10,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: 500,
                        getTitlesWidget: (value, meta) {
                          return Transform.rotate(
                            angle: -pi / 2,
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 &&
                              index < _currentWorkerNames.length) {
                            return Transform.rotate(
                              angle: -pi / 2,
                              child: Text(
                                _currentWorkerNames[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      axisNameSize: 36,
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: true),
                  barTouchData: BarTouchData(enabled: true),
                  maxY: 5000,
                  minY: 0,
                ),
              ),
              Positioned(
                left: -15,
                right: 37,
                top: (_chartHeight * 2500) / (5000 - 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: const Text(
                          '2500',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 244, 98, 54),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned.fill(
              //   child: Stack(
              //     children: _currentBarChartValues.asMap().entries.map((entry) {
              //       int index = entry.key;
              //       double value = entry.value;
              //       return Positioned(
              //         left: (index * 60) + 20, // по х
              //         bottom: value + 10, // по y
              //         child: Text(
              //           value.toString(),
              //           style: const TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
            ]),
          ),
        ));
  }
}
