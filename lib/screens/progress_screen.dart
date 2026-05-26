import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weightData = [
      FlSpot(1, 60),
      FlSpot(2, 59.5),
      FlSpot(3, 59),
      FlSpot(4, 58.5),
      FlSpot(5, 58),
    ];

    final caloriesData = [
      FlSpot(1, 1200),
      FlSpot(2, 1500),
      FlSpot(3, 1800),
      FlSpot(4, 1600),
      FlSpot(5, 2000),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress Charts"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ChartCard(
              title: "Weight Progress",
              spots: weightData,
              color: Colors.green,
              minY: 55,
              maxY: 62,
            ),
            const SizedBox(height: 20),
            ChartCard(
              title: "Calories Progress",
              spots: caloriesData,
              color: Colors.red,
              minY: 0,
              maxY: 2500,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final List<FlSpot> spots;
  final Color color;
  final double minY;
  final double maxY;

  const ChartCard({
    super.key,
    required this.title,
    required this.spots,
    required this.color,
    required this.minY,
    required this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  minY: minY,
                  maxY: maxY,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: color,
                      barWidth: 4,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}