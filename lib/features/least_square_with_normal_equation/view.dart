import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LeastSquareWithNormalEquationPage extends StatelessWidget {
  final controller = Get.put(LeastSquareWithNormalEquationController());

  @override
  Widget build(BuildContext context) {
    // controller.constructFullEquation();
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.constructFullEquation()),
      ),
      body: Column(
        children: [
          Text(controller.constructFullEquation()),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: controller.getOgPoints(),
                        isCurved: false,
                        dotData: const FlDotData(
                          show: true,
                        ),
                        color: Colors.red,
                        barWidth: 0,
                        isStepLineChart: true,
                      ),
                      LineChartBarData(
                        spots: controller.getPointsForFullEquations(),
                        isCurved: false,
                        color: Colors.indigo,
                        barWidth: 1,
                        dotData: const FlDotData(
                          show: false,
                        ),
                        isStepLineChart: false,
                      )
                    ],
                    minX: controller.getMinX(),
                    maxX: controller.getMaxX(),
                    minY: controller.getMinY(),
                    maxY: controller.getMaxY(),
                    titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            return Transform.rotate(
                              angle: 12,
                              // origin: Offset(-20, 16),
                              child: Text(
                                value.toString(),
                                style: Get.textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF8E0F0F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            );
                          },
                        )),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  String text = (60 * value).toString();

                                  return Text(
                                    value.toString(),
                                    style: Get.textTheme.bodyMedium?.copyWith(
                                        color: const Color(0xFF8E0F0F),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  );
                                })),
                        rightTitles: const AxisTitles(
                          drawBelowEverything: false,
                        ),
                        topTitles:
                            const AxisTitles(drawBelowEverything: false)),
                    gridData: const FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                    ),
                    borderData: FlBorderData(
                      border: const Border(
                        top: BorderSide(
                          width: 0,
                          color: Color(
                            0x91ADC5FF,
                          ),
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: Color(
                            0xFFB5B5B5,
                          ),
                        ),
                        left: BorderSide(
                          width: 1,
                          color: Color(
                            0xFFB5B5B5,
                          ),
                        ),
                        right: BorderSide(
                          width: 0,
                          color: Color(
                            0x91ADC5FF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
