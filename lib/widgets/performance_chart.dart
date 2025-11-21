import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/constants.dart';

class PerformanceChart extends StatelessWidget {
  final Map<String, int> benchmarkScores;

  const PerformanceChart({Key? key, required this.benchmarkScores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (benchmarkScores.isEmpty) {
      return Center(
        child: Text(
          'No benchmark data available',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => AppColors.textPrimary,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String category = benchmarkScores.keys.elementAt(group.x);
                return BarTooltipItem(
                  '$category\n${rod.toY.round()}%',
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
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
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  );
                  String title = benchmarkScores.keys.elementAt(value.toInt());
                  
                  // Abbreviate long titles
                  switch (title) {
                    case '4K Gaming':
                      title = '4K';
                      break;
                    case '1440p Gaming':
                      title = '1440p';
                      break;
                    case 'Ray Tracing':
                      title = 'RT';
                      break;
                    case 'Content Creation':
                      title = 'Content';
                      break;
                  }
                  
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(title, style: style),
                  );
                },
                reservedSize: 30,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 25,
                getTitlesWidget: (double value, TitleMeta meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      '${value.toInt()}%',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: benchmarkScores.entries.map((entry) {
            int index = benchmarkScores.keys.toList().indexOf(entry.key);
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: entry.value.toDouble(),
                  color: _getBarColor(entry.value),
                  width: 20,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.2),
                strokeWidth: 1,
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getBarColor(int score) {
    if (score >= 90) {
      return AppColors.success;
    } else if (score >= 70) {
      return AppColors.primaryColor;
    } else if (score >= 50) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}