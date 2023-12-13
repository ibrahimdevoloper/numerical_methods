import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:numerical_method/core/models/least_square_problem_model.dart';
import 'package:numerical_method/features/least_square_with_normal_equation/view.dart';
import 'package:numerical_method/features/least_square_with_normal_equation_points/controller.dart';
import 'package:numerical_method/features/least_square_with_normal_equation_subequations/controller.dart';
import 'package:math_expressions/math_expressions.dart';

class LeastSquareWithNormalEquationController extends GetxController
    with
        LeastSquareWithNormalEquationPointsController,
        LeastSquareWithNormalEquationSubequationsController {
  List<double> solution = [];

  Future<void> solveLeastSquareProblem() async {
    try {
      List<double> xPoints = [];
      List<double> yPoints = [];
      for (var coordinate in coordinates) {
        xPoints.add(coordinate['x']!);
        yPoints.add(coordinate['y']!);
      }

      var inputModel = {
        'equations': equationExpressions,
        'xPoints': xPoints,
      };
      var matrix = await computeLSPMatrix(inputModel);
      LeastSquareProblemModel leastSquareProblem =
          LeastSquareProblemModel(matrix, yPoints);
      solution = leastSquareProblem.solve();
      update();
      if (solution.isNotEmpty) {
        Get.to(() => LeastSquareWithNormalEquationPage());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<List<List<double>>> computeLSPMatrix(
      Map<String, dynamic> startModelMap) async {
    List<Expression> equations = startModelMap['equations'];
    List xPoints = startModelMap['xPoints'];

    List<List<double>> matrix = [
      List<double>.generate(xPoints.length, (int index) => 1)
    ];
    Variable x = Variable('x');
    ContextModel cm = ContextModel();

    for (var equation in equations) {
      List<double> row = [];
      for (var xPoint in xPoints) {
        cm.bindVariable(x, Number(xPoint));
        row.add(equation.evaluate(EvaluationType.REAL, cm));
      }
      matrix.add(row);
    }
    return matrix;
  }

  getMaxX() {
    double max = 0;
    for (var coordinate in coordinates) {
      if (coordinate['x']! > max) {
        max = coordinate['x']!;
      }
    }
    return max.ceilToDouble() + 2;
  }

  getMinX() {
    double min = 0;
    for (var coordinate in coordinates) {
      if (coordinate['x']! < min) {
        min = coordinate['x']!;
      }
    }
    return min.floorToDouble() - 2;
  }

  getMinY() {
    double min = 0;
    for (var coordinate in coordinates) {
      if (coordinate['y']! < min) {
        min = coordinate['y']!;
      }
    }
    return min.floorToDouble() - 2;
  }

  getMaxY() {
    double max = 0;
    for (var coordinate in coordinates) {
      if (coordinate['y']! > max) {
        max = coordinate['y']!;
      }
    }
    return max.ceilToDouble() + 2;
  }

  getOgPoints() {
    List<FlSpot> spots = [];
    for (var coordinate in coordinates) {
      spots.add(FlSpot(coordinate['x']!, coordinate['y']!));
    }
    return spots;
  }

  constructFullEquation() {
    String fullEquation = "${solution[0].toPrecision(4)}";
    for (var i = 0; i < equations.length; i++) {
      fullEquation +=
          " + (${equations[i]} * ${solution[i + 1].toPrecision(4)})";
      // if (i != equations.length - 1) {
      //   fullEquation += " + ";
      // }
    }
    print(fullEquation);
    return fullEquation;
  }

  getPointsForFullEquations() {
    List<FlSpot> spots = [];
    try {
      double minX = getMinX();
      double maxX = getMaxX();
      double step = (maxX - minX) / 100;
      Variable x = Variable('x');
      ContextModel cm = ContextModel();
      Parser p = Parser();
      Expression expression = p.parse(constructFullEquation());
      for (double i = minX; i <= maxX; i += step) {
        cm.bindVariable(x, Number(i));
        double y = 0;
        y = expression.evaluate(EvaluationType.REAL, cm);
        spots.add(FlSpot(i, y));
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    return spots;
  }
}

class LSPStartModel {
  List<Expression> equations;
  List xPoints;

  LSPStartModel(this.equations, this.xPoints);
}
