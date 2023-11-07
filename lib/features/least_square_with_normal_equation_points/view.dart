import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numerical_method/features/least_square_with_normal_equation/controller.dart';
import 'package:numerical_method/features/least_square_with_normal_equation_subequations/view.dart';
import 'dart:math';

import 'controller.dart';

class LeastSquareWithNormalEquationPointsPage extends StatelessWidget {
  final controller = Get.put(LeastSquareWithNormalEquationController());

  final _coordinatesFormKey = GlobalKey<FormState>();
  final _generatedPointsFormKey = GlobalKey<FormState>();

  var xController = TextEditingController();
  var yController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordinates Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<LeastSquareWithNormalEquationController>(
            init: controller,
            builder: (controller) {
              return Column(
                children: [
                  Form(
                    key: _coordinatesFormKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: xController,
                            decoration:
                                InputDecoration(labelText: 'X Coordinate'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              var doubleValue = double.tryParse(value ?? "");
                              return doubleValue == null
                                  ? "please add a value"
                                  : null;
                            },
                            onChanged: (value) {
                              var doubleValue = double.tryParse(value ?? "");
                              controller.xCoordinate = doubleValue;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: yController,
                            decoration:
                                InputDecoration(labelText: 'Y Coordinate'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              var doubleValue = double.tryParse(value ?? "");
                              return doubleValue == null
                                  ? "please add a value"
                                  : null;
                            },
                            onChanged: (value) {
                              var doubleValue = double.tryParse(value ?? "");
                              controller.yCoordinate = doubleValue;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_coordinatesFormKey.currentState?.validate() ==
                                true) {
                              xController.text = "";
                              yController.text = "";
                              controller.addCoordinate();
                            }
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _generatedPointsFormKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Generated points range start'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  return intValue == null
                                      ? "please add a value"
                                      : null;
                                },
                                onChanged: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  controller.rangeStart = intValue;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Generated points range end'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  return intValue == null
                                      ? "please add a value"
                                      : null;
                                },
                                onChanged: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  controller.rangeEnd = intValue;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.generatePointsController,
                                decoration: InputDecoration(
                                    labelText: 'Number of Points to Generate'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  return intValue == null
                                      ? "please add a value"
                                      : null;
                                },
                                onChanged: (value) {
                                  var intValue = int.tryParse(value ?? "");
                                  controller.numberOfGeneratedPoints = intValue;
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                if (_generatedPointsFormKey.currentState
                                        ?.validate() ==
                                    true) {
                                  controller.generatePoints();
                                }
                              },
                              child: Text('Generate Points'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 16),
                  // Text('Number of Generated Points: $numberOfGeneratedPoints'),
                  SizedBox(height: 16),
                  Text('Sorted Coordinates by X:'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.coordinates.length,
                      itemBuilder: (context, index) {
                        final coordinate = controller.coordinates[index];
                        return Card(
                          child: ListTile(
                            leading: Text('${index + 1}'),
                            title: Text(
                                'X: ${coordinate['x']}, Y: ${coordinate['y']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  controller.removeCoordinate(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add code to navigate to the next page here.
                      Get.to(() =>
                          LeastSquareWithNormalEquationSubequationsPage());
                    },
                    child: Text('Next Page'),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
