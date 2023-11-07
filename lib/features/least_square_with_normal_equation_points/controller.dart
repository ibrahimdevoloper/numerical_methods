import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LeastSquareWithNormalEquationPointsController on GetxController {

  List<Map<String, double>> coordinates = [];
  int? numberOfGeneratedPoints = 0;
  int? rangeStart;
  int? rangeEnd;
  double? xCoordinate;
  double? yCoordinate;
  TextEditingController generatePointsController = TextEditingController();

  void addCoordinate() {
    double? x = xCoordinate;
    double? y = yCoordinate;

    if (x != null && y != null) {
      coordinates.add({'x': x, 'y': y});
      coordinates.sort((a, b) => (a['x']??0)>=(b['x']??0)?1:0);
      xCoordinate =null;
      yCoordinate =null;
    }
    update();
  }

  void generatePoints() {
    int? count = int.tryParse(generatePointsController.text);
    if (count != null) {
      numberOfGeneratedPoints = count;
      generateRandomPoints(count);
    }
    update();
  }

  void generateRandomPoints(int count) {
    final random = Random();
    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * (rangeEnd!-rangeStart!) + (rangeStart!); // Adjust the range as needed
      final y = random.nextDouble() * (rangeEnd!-rangeStart!) + (rangeStart!); // Adjust the range as needed
      coordinates.add({'x': x, 'y': y});
    }
    coordinates.sort((a, b) => (a['x']??0)>=(b['x']??0)?1:0);
    update();
  }

  void removeCoordinate(int index) {
    // setState(() {
    coordinates.removeAt(index);
    update();
    // });
  }

}
