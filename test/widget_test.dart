import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_app/main.dart';

void main() {
  test('average of the four students is 66.25', () {
    final students = [
      Student(name: 'a', grade: 92),
      Student(name: 'b', grade: 48),
      Student(name: 'c', grade: 71),
      Student(name: 'd', grade: 54),
    ];
    expect(average(students), 66.25);
    expect(average([]), 0);
  });

  testWidgets('shows average and raises a grade on tap', (tester) async {
    await tester.pumpWidget(const GradesApp());

    expect(find.text('ממוצע: 66.3'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsNWidgets(2));
    expect(find.byIcon(Icons.cancel), findsNWidgets(2));

    // יוסף (54) הוא הרביעי ברשימה — שתי העלאות של 5 מביאות אותו ל-64 ועובר
    await tester.tap(find.byIcon(Icons.add).at(3));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add).at(3));
    await tester.pump();

    expect(find.text('ציון: 64'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
    expect(find.text('ממוצע: 68.8'), findsOneWidget);
  });

  testWidgets('adds a new student with a grade', (tester) async {
    await tester.pumpWidget(const GradesApp());

    await tester.tap(find.text('הוספת ציון'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'מיכל');
    await tester.enterText(find.byType(TextField).at(1), '80');
    await tester.tap(find.text('הוספה'));
    await tester.pumpAndSettle();

    expect(find.text('מיכל'), findsOneWidget);
    expect(find.text('ציון: 80'), findsOneWidget);
    expect(find.text('ממוצע: 69.0'), findsOneWidget); // (265+80)/5
  });
}
