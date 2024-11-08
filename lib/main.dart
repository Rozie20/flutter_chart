import 'dart:async';

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
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        //dialogBackgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        //useMaterial3: true,
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
//String _selectedChartType = 'Линейный';
//String _selectedChartType = 'Столбчатый';
  final double _chartHeight = 6;

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

  final List<double> _barChartValues1 = [8, 10, 6, 12];
  final List<double> _barChartValues2 = [5, 7, 8, 10];

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

// @override
// Widget build(BuildContext context) {
// return Scaffold(
// appBar: AppBar(
// backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// title: Text(widget.title),
// ),
// body: Column(
// children: [
// DropdownButton<String>(
// value: _selectedChartType,
// items: <String>['Линейный', 'Столбчатый', 'Круговой']
// .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (String? newValue) {
// setState(() {
// _selectedChartType = newValue!;
// });
// },
// ),
// Expanded(child: _buildChart()),
// ],
// ),
// );
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: const Color.fromARGB(255, 188, 225, 255),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            _chartTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          //const SizedBox(height: 15,),
          Expanded(child: _buildChart()),
        ],
      ),
    );
  }

  Widget _buildChart() {
// switch (_selectedChartType) {
// case 'Линейный':
// return SizedBox(
// height: _chartHeight,
// child: LineChart(
// LineChartData(
// gridData: const FlGridData(show: false),
// titlesData: const FlTitlesData(
// leftTitles:
// AxisTitles(sideTitles: SideTitles(showTitles: true)),
// bottomTitles:
// AxisTitles(sideTitles: SideTitles(showTitles: true)),
// ),
// borderData: FlBorderData(show: true),
// lineBarsData: [
// LineChartBarData(
// spots: [
// FlSpot(0, 1),
// FlSpot(1, 3),
// FlSpot(2, 2),
// FlSpot(3, 4),
// FlSpot(4, 3),
// ],
// isCurved: true,
// color: Colors.blue,
// dotData: const FlDotData(show: false),
// belowBarData: BarAreaData(show: false),
// ),
// ],
// ),
// ),
// );
// case 'Столбчатый':
// return SizedBox(
// height: _chartHeight,
// child: BarChart(
// BarChartData(
// alignment: BarChartAlignment.spaceAround,
// barGroups: _barChartValues.asMap().entries.map((entry) {
// int index = entry.key;
// double value = entry.value;

// return BarChartGroupData(
// x: index,
// barRods: [
// BarChartRodData(
// toY: value,
// color: Colors.blue,
// width: 20,
// borderRadius: BorderRadius.circular(5),
// ),
// ],
// );
// }).toList(),
// titlesData: FlTitlesData(
// bottomTitles: AxisTitles(
// sideTitles: SideTitles(
// showTitles: true,
// reservedSize: 40,
// interval: 1,
// getTitlesWidget: (value, meta) {
// return Text(
// _workerNames[value.toInt()], // Отображение ФИО
// style: TextStyle(color: Colors.black, fontSize: 10),
// textAlign: TextAlign.center,
// );
// },
// ),
// ),
// ),
// borderData: FlBorderData(show: true),
// gridData: FlGridData(show: true),
// barTouchData: BarTouchData(enabled: true),
// maxY: _barChartValues.reduce((a, b) => a > b ? a : b) + 1,
// ),
// ),
// );

// case 'Круговой':
// return SizedBox(
// height: _chartHeight,
// child: PieChart(
// PieChartData(
// sections: [
// PieChartSectionData(
// value: 40, title: '40%', color: Colors.blue),
// PieChartSectionData(
// value: 30, title: '30%', color: Colors.green),
// PieChartSectionData(value: 20, title: '20%', color: Colors.red),
// PieChartSectionData(
// value: 10, title: '10%', color: Colors.yellow),
// ],
// ),
// ),
// );
// default:
// return Container();
// }

    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 40),
      child: SizedBox(
        height: _chartHeight,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceBetween,
            //groupsSpace: 60,
            barGroups: _currentBarChartValues.asMap().entries.map((entry) {
              int index = entry.key;
              double value = entry.value;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: value,
                    color: const Color.fromARGB(255, 34, 167, 201),
                    width: 50,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              );
            }).toList(),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 180,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < _currentWorkerNames.length) {
                      return Text(
                        _currentWorkerNames[index],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return Text('');
                    }
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  interval: 500,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      (value.toInt() * 500).toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      textAlign: TextAlign.center,
                    );
                  },
                  // rotateAngle: 45,
                  // showTitles: false,
                ),
              ),
              topTitles: const AxisTitles(
                axisNameSize: 36,
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            gridData: const FlGridData(show: true),
            barTouchData: BarTouchData(enabled: true),
            maxY: _currentBarChartValues.reduce((a, b) => a > b ? a : b) + 1,
          ),
        ),
      ),
    );
  }
}
