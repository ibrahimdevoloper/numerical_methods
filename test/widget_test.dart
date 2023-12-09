// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numerical_method/core/models/cholesky_decomposion.dart';

import 'package:numerical_method/main.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test("test Cholesky method for lower part", () {
    var matrix = [
      [9.0, -6.0, 3.0],
      [-6.0, 5.0, 0.0],
      [3.0, 0.0, 6.0]
    ];
    var b = [
      [3.0, 0, 0],
      [-2.0, 1, 0],
      [1, 2, 1]
    ];
    var result = CholeskyDecomposition(matrix);
    expect(result.decompose(), b);
  });

  test("test Cholesky method for upper part", () {
    var matrix = [
      [9.0, -6.0, 3.0],
      [-6.0, 5.0, 0.0],
      [3.0, 0.0, 6.0]
    ];
    var b = [
      [3.0, -2.0, 1],
      [0, 1, 2],
      [0, 0, 1]
    ];
    var result = CholeskyDecomposition(matrix);
    expect(result.getUpper(), b);
  });

  test("test Cholesky method for is Positive Definite", () {
    var matrix = [
      [9.0, -6.0, 3.0],
      [-6.0, 5.0, 0.0],
      [3.0, 0.0, 6.0]
    ];
    var b = [
      [3.0, -2.0, 1],
      [0, 1, 2],
      [0, 0, 1]
    ];
    var result = CholeskyDecomposition(matrix);
    expect(result.isSymmetric(), true);
  });
}
