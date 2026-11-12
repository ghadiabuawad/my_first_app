// ignore_for_file: avoid_print
// תחנה 4 — פונקציות
// הרצה: dart run bin/station4_functions.dart

// 1. פרמטרים רגילים (מיקומיים) — חובה, לפי הסדר
int add(int a, int b) {
  return a + b;
}

// 2. פרמטרים מיקומיים אופציונליים — בסוגריים מרובעים, עם ערך ברירת מחדל
String greet(String name, [String greeting = 'Hello']) {
  return '$greeting, $name';
}

// 3. + 4. פרמטרים בשם — בסוגריים מסולסלים: אחד required ואחד אופציונלי
// כאן גם פונקציית חץ (=>): קיצור לפונקציה שמחזירה ביטוי אחד
String describe({required String name, int grade = 0}) =>
    '$name got $grade (${grade >= 56 ? 'passed' : 'failed'})';

void main() {
  print(add(2, 3));
  print(greet('Dana'));
  print(greet('Dana', 'Shalom'));

  // פונקציה עם פרמטרים בשם שעובדת על 4 קריאות
  print(describe(name: 'Noa', grade: 92));
  print(describe(grade: 48, name: 'Omer')); // בשמות — הסדר לא משנה
  print(describe(name: 'Dana', grade: 71));
  print(describe(name: 'Yosef')); // grade מקבל ברירת מחדל 0

  // פונקציה אנונימית — פונקציה בלי שם, שמעבירים כערך
  final grades = [92, 48, 71, 54];
  final passed = grades.where((g) => g >= 56).toList();
  print('Passed: $passed');

  // closure — פונקציה ש"זוכרת" משתנה מהסביבה שבה נוצרה
  Function() makeCounter() {
    var count = 0;
    return () => ++count;
  }

  final counter = makeCounter();
  counter();
  counter();
  print('Counter: ${counter()}'); // 3
}
