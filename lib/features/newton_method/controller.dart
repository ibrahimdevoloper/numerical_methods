import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';
import 'package:numerical_method/core/models/newton_model.dart';
import 'package:numerical_method/features/newton_method_summary/view.dart';

class NewtonMethodController extends GetxController {
  String function = "";
  int _numberOfIterations = 100;
  double rangeStart = 0;
  double rangeEnd = 0.0001;
  double _error = 0.000001;
  List<double> values = [];
  bool _isLoading = false;

  late Expression expression;

  startNewtonMethod() async {
    isLoading = true;
    try {
      Parser p = Parser();
      expression = p.parse(function);
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Input Function Error",
          duration: Duration(milliseconds: 1500),
        ),
      );
      isLoading = false;
      return null;
    }

    var inputModel = NewtonModel(
      expression: expression,
      numberOfIterations: numberOfIterations,
      rangeStart: rangeStart,
      rangeEnd: rangeEnd,
      error: error,
    );

    if ((inputModel.ogFunction(rangeStart) * inputModel.ogFunction(rangeEnd)) >
        0) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "condition: f(start range)*f(end range)<0 is not satisfied",
          duration: Duration(milliseconds: 1500),
        ),
      );
      isLoading = false;
      return null;
    }

    var model = await compute<NewtonModel, NewtonModel?>(
        (message) => computeNewtonMethod(message), inputModel);

    if (model == null) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Cannot Converge within this range",
          duration: Duration(milliseconds: 1500),
        ),
      );
      isLoading = false;
      return null;
    }

    Get.to(() => NewtonMethodSummaryPage(
          function: function,
          initialValue: model.values.first,
          finalError: model.finalError,
          finalValue: model.values.last,
          values: model.values,
        ));
    isLoading = false;
  }

  static Future<NewtonModel?> computeNewtonMethod(NewtonModel model) async {
    double? initialValue;

    for (var i = model.rangeStart;
        i <= model.rangeEnd;
        i += (model.rangeEnd - model.rangeStart) / 100) {
      if (!model.convergenceCondition(i)) {
        return null;
      }
    }
    initialValue = (model.rangeStart + model.rangeEnd) / 2;
    model.values = [initialValue];
    for (int i = 0; (i < model.numberOfIterations); i++) {
      model.finalError = model.errorEstimation(
          model.values[i], (i > 0 ? model.values[i - 1] : 0));
      if ((model.error >
              model.errorEstimation(
                  model.values[i], (i > 0 ? model.values[i - 1] : 0))) ||
          model.firstOrderDerivativeNumerical(model.values.last) == 0) break;
      model.values.add(model.values.last -
          (model.ogFunction(model.values.last) /
              model.firstOrderDerivativeNumerical(model.values.last)));
    }

    return model;
  }

  int get numberOfIterations => _numberOfIterations;

  set numberOfIterations(int value) {
    _numberOfIterations = value;
    update();
  }

  double get error => _error;

  set error(double value) {
    _error = value;
    update();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }
}
