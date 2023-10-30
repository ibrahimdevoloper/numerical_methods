import 'dart:math';
import 'package:math_expressions/math_expressions.dart';


class NewtonModel {
  int numberOfIterations = 100;
  double rangeStart = 0;
  double rangeEnd = 0.0001;
  double error = 0.000001;
  double finalError = 0;
  List<double> values = [];

  Parser p = Parser();
  Variable x = Variable('x');
  Expression expression;

  // Expression expression = p.parse("(x^3 + cos(x)) / 3");
  ContextModel cm = ContextModel();

  NewtonModel({
    required this.expression,
    required this.numberOfIterations,
    required this.rangeStart,
    required this.rangeEnd,
    required this.error,
  });

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
  bool convergenceCondition(x) {
    // print("x: ${x}");
    // print("fx: ${ogFunction(x)}");
    // print("dfx: ${firstOrderDerivativeNumerical(x)}");
    // print("dfx2: ${pow(firstOrderDerivativeNumerical(x), 2)}");
    // print("d2fx: ${secondOrderDerivativeNumerical(x)}");
    var convergence = (secondOrderDerivativeNumerical(x) *
        ogFunction(x) /
        pow(firstOrderDerivativeNumerical(x), 2))
        .abs();
    // if (convergence < 1 && convergence > 0) {
    //   print("x: ${x}");
    //   print("fx: ${ogFunction(x)}");
    //   print("dfx: ${firstOrderDerivativeNumerical(x)}");
    //   print("dfx2: ${pow(firstOrderDerivativeNumerical(x), 2)}");
    //   print("d2fx: ${secondOrderDerivativeNumerical(x)}");
    //   print("convergence: $convergence");
    // }
    return convergence < 1 && convergence > 0;
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