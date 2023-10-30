import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class NewtonMethodSummaryPage extends StatelessWidget {
  final controller = Get.put(NewtonMethodSummaryController());
  final String function;
  final double initialValue;
  final double finalValue;
  final double finalError;
  final List<double> values;

  NewtonMethodSummaryPage({
    super.key,
    required this.function,
    required this.initialValue,
    required this.finalValue,
    required this.finalError,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solution for $function=0'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Initial Value: $initialValue'),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Final Value: $finalValue'),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Final Error Estimation: $finalError'),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text('Values:'),
              ),
            ),
            for (int i = 0; i < values.length; i++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('Iteration $i: ${values[i]}'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
