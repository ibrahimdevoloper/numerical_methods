import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';
import 'package:numerical_method/core/models/least_square_problem_model.dart';
import 'package:numerical_method/core/models/newton_model.dart';
import 'package:numerical_method/features/newton_method_summary/view.dart';

mixin LeastSquareWithNormalEquationSubequationsController on GetxController {
  List<Expression> equationExpressions = [];
  List<String> equations = [];

  void addEquation(String text) {
    try {
      Parser p = Parser();
      Expression expression = p.parse(text);
      equations.add(text);
      equationExpressions.add(expression);
      update([equationsTag]);
    } catch (e) {
      print(e);
      Get.showSnackbar(
        const GetSnackBar(
          message: "Input Function Error",
          duration: Duration(milliseconds: 1500),
        ),
      );
    }
  }

  void removeEquation(int index) {
    equationExpressions.removeAt(index);
    equations.removeAt(index);

    update([equationsTag]);
  }

  get equationsTag => "equationsTag";
}
