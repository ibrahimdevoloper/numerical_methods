import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_method/core/models/cholesky_decomposion_model.dart';

class LeastSquareProblemModel {
  List<List<double>> matrix;
  List<double> y;

  LeastSquareProblemModel(this.matrix, this.y);

  List<double> solve() {
    int columnCount = matrix[0].length;
    int rowCount = matrix.length;
    List<List<double>> transposedMatrix = List.generate(
        columnCount, (_) => List.filled(rowCount, 0.0));
    // List<double> transposedY = List.filled(rowCount, 0.0); // Calculate the transposed matrix and the transposed y
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        transposedMatrix[j][i] = matrix[i][j];
      }
      // transposedY[i] = y[i];
    }
    // Calculate the product of the transposed matrix and the original matrix
    List<List<double>> productMatrix = List.generate(
        rowCount, (_) => List.filled(rowCount, 0.0));
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < rowCount; j++) {
        //scanning loop
        for (int k = 0; k < columnCount; k++) {
          productMatrix[i][j] += matrix[i][k] * transposedMatrix[k][j];
        }
      }
    }
      // Calculate the product of the transposed matrix and the transposed y
      List<double> productY = List.filled(rowCount, 0.0);
      for (int i = 0; i < rowCount; i++) {
        for (int j = 0; j < columnCount; j++) {
          productY[i] += transposedMatrix[j][i] * y[j];
        }
      }

      // Solve the system of equations using the Cholesky Decomposition
      CholeskyDecompositionModel choleskyDecomposition = CholeskyDecompositionModel(
          productMatrix);
      List<List<double>> lower = choleskyDecomposition.decompose();
      List<List<double>> upper = choleskyDecomposition.getUpper();

      // Forward substitution
      List<double> z = List.filled(rowCount, 0.0);
      for (int i = 0; i < rowCount; i++) {
        double sum = 0;
        for (int j = 0; j < i; j++) {
          sum += lower[i][j] * z[j];
        }
        z[i] = (productY[i] - sum) / lower[i][i];
      }

      // Backward substitution
      List<double> b = List.filled(rowCount, 0.0);
      for (int i = rowCount - 1; i >= 0; i--) {
        double sum = 0;
        for (int j = i + 1; j < rowCount; j++) {
          sum += upper[i][j] * b[j];
        }
        b[i] = (z[i] - sum) / upper[i][i];
      }

      return b;

  }
}