import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_app/core/widgets/loader.dart';

import 'utils.dart';

void main() {
  testWidgets('Проверка loader', (tester) async {
    await tester.pumpWidget(testableWidget(child: const LoaderWidget()));
    await tester.pump();
    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    expect(progressIndicatorFinder, findsOneWidget);
  });
}