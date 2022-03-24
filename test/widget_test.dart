// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:college_match/core/values/firebase_constants.dart';
import 'package:college_match/data/model/interest_model.dart';
import 'package:college_match/data/services/question_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:college_match/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Service Test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    await firebaseInitialization.then((_) {});
    await tester.pumpWidget(MyApp());
    final service = QuestionService();
    final questions = await service.getAllMajor();
    print(questions[0].major);
    expect(questions.length, greaterThan(0));
  });
}
