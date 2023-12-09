import 'dart:math';

class CholeskyDecomposition {
  List<List<double>> matrix;

  CholeskyDecomposition(this.matrix);

  List<List<double>> decompose() {
    if (isPositiveDefinite() && isSymmetric()) {
      int n = matrix.length;
      List<List<double>> lower = List.generate(n, (_) => List.filled(n, 0.0));

      for (int i = 0; i < n; i++) {
        for (int j = 0; j <= i; j++) {
          double sum = 0;

          if (j == i) {
            for (int k = 0; k < j; k++) {
              sum += lower[j][k] * lower[j][k];
            }
            lower[j][j] = sqrt(matrix[j][j] - sum);
          } else {
            for (int k = 0; k < j; k++) {
              sum += (lower[i][k] * lower[j][k]);
            }
            lower[i][j] = (matrix[i][j] - sum) / lower[j][j];
          }
        }
      }

      return lower;
    } else {
      throw Exception("Matrix is not positive definite or symmetric");
    }
  }

  List<List<double>> getUpper() {
    List<List<double>> lower = decompose();
    int n = lower.length;
    List<List<double>> upper = List.generate(n, (_) => List.filled(n, 0.0));

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        upper[j][i] = lower[i][j];
      }
    }

    return upper;
  }

  bool isSymmetric() {
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < i; j++) {
        if (matrix[i][j] != matrix[j][i]) {
          return false;
        }
      }
    }
    return true;
  }

  bool isPositiveDefinite() {
    for (int i = 0; i < matrix.length; i++) {
      List<List<double>> subMatrix =
          matrix.sublist(0, i + 1).map((row) => row.sublist(0, i + 1)).toList();
      if (determinant(subMatrix) <= 0) {
        return false;
      }
    }
    return true;
  }

  double determinant(List<List<double>> matrix) {
    var total = 0.0;
    var sign = 1;
    if (matrix.length == 1) {
      return matrix[0][0];
    } else if (matrix.length == 2) {
      return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    } else {
      for (var i = 0; i < matrix[0].length; i++) {
        //create a empty matrix for smaller dimensions
        var smaller = List.generate(
            matrix.length - 1, (_) => List.filled(matrix[0].length - 1, 0.0),
            growable: false);
        for (var a = 1; a < matrix.length; a++) {
          var smallerCol = 0;
          for (var b = 0; b < matrix[0].length; b++) {
            if (b != i) {
              // start from
              smaller[a - 1][smallerCol] = matrix[a][b];
              smallerCol++;
            }
          }
        }
        print(smaller);
        total += sign * matrix[0][i] * determinant(smaller);
        sign *= -1;
      }
    }
    return total;
  }
}
