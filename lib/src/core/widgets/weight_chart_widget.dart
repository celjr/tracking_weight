// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:tracking_weight/src/modules/weight/models/weight_model.dart';

class WeightChartWidget extends StatelessWidget {
  const WeightChartWidget({
    Key? key,
    required this.weights,
  }) : super(key: key);
  final List<WeightModel> weights;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Dia 1', style: style);
        break;
      case 31:
        text = const Text('Dia 30', style: style);
        break;
      case 61:
        text = const Text('Dia 60', style: style);
        break;
      case 91:
        text = const Text('Dia 90', style: style);
        break;
      case 121:
        text = const Text('Dia 120', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 25:
        text = '25Kg';
        break;
      case 50:
        text = '50Kg';
        break;
      case 75:
        text = '75Kg';
        break;
      case 100:
        text = '100Kg';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> weightToChartData(List<WeightModel> list) {
    List<FlSpot> spots = [];
    DateTime firstDay = list.first.date;
    for (WeightModel weight in list) {
      final diff = weight.date.difference(firstDay);
      print(diff.inDays.toDouble());
      spots.add(FlSpot(diff.inDays.toDouble(), weight.weight));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        gridData: FlGridData(
          show: false,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Theme.of(context).primaryColor,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Theme.of(context).primaryColor,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: leftTitleWidgets,
              reservedSize: 42,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(isCurved: true, spots: weightToChartData(weights)),
        ]));
  }
}
