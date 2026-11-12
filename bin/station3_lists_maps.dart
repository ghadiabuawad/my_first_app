// ignore_for_file: avoid_print
// תחנה 3 — רשימות ומפות
// הרצה: dart run bin/station3_lists_maps.dart

void main() {
  // List — רשימה מסודרת לפי אינדקס (מתחיל מ-0)
  final grades = <int>[92, 48, 71];
  grades.add(54); // הוספה
  print('First grade: ${grades[0]}'); // גישה
  grades.remove(48); // מחיקה
  grades.add(48);

  // לולאה: סכום, מקסימום וספירת עוברים
  var sum = 0;
  var max = grades[0];
  var passed = 0;
  for (final g in grades) {
    sum += g;
    if (g > max) max = g;
    if (g >= 56) passed++;
  }
  final average = sum / grades.length;
  print('Average: ${average.toStringAsFixed(1)}');
  print('Max: $max');
  print('Passed: $passed of ${grades.length}');

  // Map — מיפוי ממפתח לערך
  final students = <String, int>{'Noa': 92, 'Omer': 48};
  students['Dana'] = 71; // הוספה
  print('Noa got ${students['Noa']}'); // גישה
  students.remove('Omer'); // מחיקה
  students.forEach((name, grade) => print('$name: $grade')); // לולאה
}
