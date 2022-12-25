import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../domain/entities/entities.dart';

class ChartComponent extends StatelessWidget {
  final List<VariationEntity> variations;

  const ChartComponent({
    Key? key,
    required this.variations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ColorsConstants.text,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;

    if (value == 1 || value.toInt() % 15 == 0 || value == variations.length) {
      text = Text(
        DateTimeUtils.formattedDate(variations[value.toInt() - 1].date),
        style: style,
      );
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ColorsConstants.text,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    return Text(
      PriceUtils.convert(value),
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData mainData() {
    int index = 0;

    double highest = variations.reduce((a, b) {
      if (a.value > b.value) {
        return a;
      } else {
        return b;
      }
    }).value;

    double lowest = variations.reduce((a, b) {
      if (a.value < b.value) {
        return a;
      } else {
        return b;
      }
    }).value;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          maxContentWidth: 250,
          tooltipBgColor: ColorsConstants.backgroundDark,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              const textStyle = TextStyle(
                color: ColorsConstants.text,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              return LineTooltipItem(
                '${DateTimeUtils.formattedDate(
                  variations[touchedSpot.x.toInt() - 1].date,
                )}\n'
                '${PriceUtils.convert(touchedSpot.y)}',
                textStyle,
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        getTouchLineStart: (data, index) => 0,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorsConstants.divider.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ColorsConstants.divider.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
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
            interval: (highest - lowest).toInt().toString().length.toDouble(),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 70,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ColorsConstants.divider.withOpacity(0.2)),
      ),
      minX: 1,
      maxX: variations.length.toDouble(),
      minY: variations.reduce((a, b) {
        if (a.value < b.value) {
          return a;
        } else {
          return b;
        }
      }).value,
      maxY: variations.reduce((a, b) {
        if (a.value > b.value) {
          return a;
        } else {
          return b;
        }
      }).value,
      lineBarsData: [
        LineChartBarData(
          spots: variations.map((element) {
            index++;
            return FlSpot(index.toDouble(), element.value);
          }).toList(),
          isCurved: false,
          color: ColorsConstants.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: ColorsConstants.primary.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
