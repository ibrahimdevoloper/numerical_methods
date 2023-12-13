import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numerical_method/features/least_square_with_normal_equation/controller.dart';
import 'package:numerical_method/features/least_square_with_normal_equation/view.dart';

import 'controller.dart';

class LeastSquareWithNormalEquationSubequationsPage extends StatelessWidget {
  final controller = Get.find<LeastSquareWithNormalEquationController>();

  TextEditingController mainEquationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub-equations Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: mainEquationsController,
                    decoration: const InputDecoration(
                      labelText: 'Function Expression',
                      hintText: 'ex: 1/(2*x)',
                    ),
                    validator: (value) {
                      if (value?.isEmpty != false) {
                        return "The Field is empty";
                      }
                      final validFunctionPattern = RegExp(
                          r'^[xX(,)+\-*\/0-9. \^sin|cos|tan|sqrt|exp|log|ln|abs|ceil|floor|round|trunc|toDegrees|toRadians|]*$',
                          caseSensitive: false);
                      var matcher =
                      validFunctionPattern.hasMatch((value ?? ""));
                      return !matcher
                          ? "Expression is empty or incorrect"
                          : null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.addEquation(mainEquationsController.text);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<LeastSquareWithNormalEquationController>(
                  init: controller,
                  id: controller.equationsTag,

                  builder: (controller) {
                return ListView.builder(
                  itemCount: controller.equationExpressions.length,
                  itemBuilder: (context, index) {
                    final equation = controller.equationExpressions[index];
                    return Card(
                      child: ListTile(
                        title: Text(equation.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.removeEquation(index),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                try {
                  if (controller.equationExpressions.isNotEmpty) {
                    controller.solveLeastSquareProblem();
                  } else {
                    Get.snackbar("Error", "Please add at least one equation");
                  }

                }catch(e){
                  Get.snackbar("Error", e.toString());
                }
              },
              child: const Text('Next Page'),
            ),
          ],
        ),
      ),
    );
  }
}
