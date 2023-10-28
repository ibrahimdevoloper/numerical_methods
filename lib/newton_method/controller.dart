import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';

class NewtonMethodController extends GetxController {
  String function = "";
  int _numberOfIterations = 100;
  double rangeStart = 0;
  double rangeEnd = 0.0001;
  double _error = 0.000001;
  double _finalError = 0.0001;
  List<double> values = [];

  Parser p = Parser();
  Variable x = Variable('x');
  late Expression expression;

  // Expression expression = p.parse("(x^3 + cos(x)) / 3");
  ContextModel cm = ContextModel();

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

  double? startNewtonMethod() {
    expression = p.parse(function);
    double? initialValue;
    print("object:${(ogFunction(rangeStart) * ogFunction(rangeEnd))}");
    if ((ogFunction(rangeStart) * ogFunction(rangeEnd)) > 0) {
      return null;
    }

    for (var i = rangeStart; i <= rangeEnd; i += 0.01) {
      if (converganceCondition(i)) {
        initialValue = i;
      }
    }
    if (initialValue == null) {
      return null;
    }
    //TODO: get initial value from the convergance condition.
    values = [initialValue];
    for (int i = 0; (i < numberOfIterations); i++) {
      _finalError = errorEstimation(values[i], (i > 0 ? values[i - 1] : 0));
      // print("error:${_finalError}");
      if ((error > errorEstimation(values[i], (i > 0 ? values[i - 1] : 0))) ||
          firstOrderDerivativeNumerical(values.last) == 0) break;
      values.add(values.last -
          (ogFunction(values.last) /
              firstOrderDerivativeNumerical(values.last)));
      // print(values.last);
    }
    //tODO: go to summary page (range, initial value, final value, final error estimation, values)
    print("last value:${values.last}");
    print("last error:${_finalError}");
    return values.last;
  }

  double ogFunction(double value) {
    cm.bindVariable(x, Number(value));
    double eval = expression.evaluate(EvaluationType.REAL, cm);
    return eval;
  }

  double firstOrderDerivativeNumerical(x) {
    var h = 0.0000001;
    var dfx = (-ogFunction(x + 2 * h) +
            8 * ogFunction(x + 1 * h) -
            8 * ogFunction(x - 1 * h) +
            ogFunction(x - 2 * h)) /
        (12 * h);

    return dfx;
  }

  double secondOrderDerivativeNumerical(x) {
    var h = 0.0000001;
    var ddfx = (-ogFunction(x + 2 * h) +
            16 * ogFunction(x + 1 * h) -
            30 * ogFunction(x + 0 * h) +
            16 * ogFunction(x - 1 * h) -
            ogFunction(x - 2 * h)) /
        (12 * pow(h, 2));

    return ddfx;
  }

//ref: https://www.quora.com/What-is-the-condition-for-the-convergence-of-the-Newton-Raphson-algorithm
  bool converganceCondition(x) {
    print("x: ${x}");
    print("fx: ${ogFunction(x)}");
    print("dfx: ${firstOrderDerivativeNumerical(x)}");
    print("dfx2: ${pow(firstOrderDerivativeNumerical(x), 2)}");
    print("d2fx: ${secondOrderDerivativeNumerical(x)}");
    var convergance = (secondOrderDerivativeNumerical(x) *
            ogFunction(x) /
            pow(firstOrderDerivativeNumerical(x), 2))
        .abs();
    print("convergance: $convergance");
    return convergance < 1;
  }

  bool didItConverge(double value, double error) {
    return ogFunction(value) <= error && ogFunction(value) >= -error;
  }

  double errorEstimation(double x, double previousX) {
    //TODO: put error estimation here.
    var M = secondOrderDerivativeNumerical(x).abs();
    var m = firstOrderDerivativeNumerical(x).abs();
    return M * pow(x - previousX, 2) / (2 * m);
  }
}
